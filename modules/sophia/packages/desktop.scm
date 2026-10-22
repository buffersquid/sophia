(define-module (sophia packages desktop)
  #:use-module (guix gexp)
  #:use-module (guix packages)
  #:use-module (guix packages)
  #:use-module (guix build-system trivial)
  #:use-module (guix licenses)
  #:use-module (gnu packages window-management)
  #:use-module (gnu packages xdisorg)
  #:use-module (gnu packages terminals)
  #:use-module (nongnu packages nvidia))

(define-public niri-desktop
  (package
    (name "niri-desktop")
    (version "1.0")
    (source #f)
    (build-system trivial-build-system)
    (arguments
     (list #:builder
           #~(mkdir #$output)))
    (propagated-inputs
     (list (replace-mesa niri #:driver nvda-580)
	   noctalia-shell
	   alacritty
           fuzzel))
    (synopsis "Niri Wayland desktop environment")
    (description
     "A practical desktop environment built around the Niri Wayland compositor and noctalia")
    (home-page "https://github.com/buffersquid/sophia")
    (license gpl3+)))
