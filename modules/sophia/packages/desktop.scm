(define-module (sophia packages desktop)
  #:use-module (guix gexp)
  #:use-module (guix packages)
  #:use-module (guix build-system trivial)
  #:use-module (guix licenses)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages window-management)
  #:use-module (gnu packages xdisorg)
  #:use-module (gnu packages xorg)
  #:use-module (gnu packages terminals)
  #:use-module (gnu packages music)
  #:use-module (nongnu packages nvidia)
  #:use-module (sophia config))

(define-public niri-desktop
  (package
    (name "niri-desktop")
    (version "1.0")
    (source
     #f)
    (build-system trivial-build-system)
    (arguments
     (list
      #:builder
      #~(mkdir #$output)))
    (propagated-inputs (list (replace-mesa niri
                                           #:driver %nvidia-driver)
                             (replace-mesa xwayland-satellite
                                           #:driver %nvidia-driver)
                             noctalia-shell
                             alacritty
                             fuzzel
                             wl-clipboard
                             wireplumber
                             playerctl))
    (synopsis "Niri Wayland desktop environment")
    (description
     "A practical desktop environment built around the Niri Wayland compositor and noctalia")
    (home-page "https://github.com/buffersquid/sophia")
    (license gpl3+)))
