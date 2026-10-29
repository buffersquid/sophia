(define-module (sophia packages game-runtime)
  #:use-module (guix gexp)
  #:use-module (guix packages)
  #:use-module (guix licenses)
  #:use-module (guix build-system trivial)
  #:use-module (gnu packages bash)
  #:use-module (gnu packages wine)
  #:use-module (nongnu packages nvidia)
  #:use-module (sophia config))

(define run-wine-game-script
  (plain-file "run-wine-game"
   "#!/usr/bin/env bash
set -euo pipefail

if [[ $# -lt 2 ]]; then
    echo \"Usage: run-wine-game PREFIX EXE [ARGS...]\" >&2
    exit 2
fi

PREFIX=$1
EXE=$2
shift 2

[[ \"$PREFIX\" = /* ]] || PREFIX=\"$PWD/$PREFIX\"
[[ \"$EXE\" = /* ]] || EXE=\"$PWD/$EXE\"

if [[ ! -f \"$EXE\" ]]; then
    echo \"Executable not found: $EXE\" >&2
    exit 1
fi

if [[ -z \"${DISPLAY:-}\" ]]; then
    echo \"DISPLAY is unset; launch from your Niri session.\" >&2
    exit 1
fi

mkdir -p \"$PREFIX\"
PREFIX=\"$(cd \"$PREFIX\" && pwd)\"
export WINEPREFIX=\"$PREFIX\"

unset WAYLAND_DISPLAY

if [[ ! -f \"$WINEPREFIX/system.reg\" ]]; then
    wineboot -u
fi

wine reg add 'HKCU\\Software\\Wine\\Drivers' /v Graphics /t REG_SZ /d 'x11,wayland' /f >/dev/null

cd \"$(dirname \"$EXE\")\"
exec wine \"$EXE\" \"$@\"
"))

(define-public wine-game-runner
  (package
    (name "wine-game-runner")
    (version "0.1")
    (source
     run-wine-game-script)
    (build-system trivial-build-system)

    (arguments
     (list
      #:modules '((guix build utils))
      #:builder
      #~(begin
          (use-modules (guix build utils))

          (let* ((bin (string-append #$output "/bin"))
                 (runner (string-append bin "/run-wine-game")))
            (mkdir-p bin)
            (copy-file (assoc-ref %build-inputs "source") runner)
            (patch-shebang runner
                           (list (string-append #$bash-minimal "/bin")))
            (chmod runner #o555)))))

    (inputs (list bash-minimal))

    (propagated-inputs (list (replace-mesa wine
                                           #:driver %nvidia-driver)))

    (home-page "https://github.com/buffersquid/sophia")
    (synopsis "Launch Windows games with Wine")
    (description "A reusable Wine game launcher for Guix and Niri.")
    (license gpl3+)))
