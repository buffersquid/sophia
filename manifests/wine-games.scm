(use-modules (guix profiles)
             (gnu packages wine)
             (gnu packages xorg)
             (nongnu packages nvidia)
             (sophia config))

(define wine-game-packages
  (list wine xwayland-satellite xrandr))

(packages->manifest (append (map (lambda (package
                                           )
                                   (replace-mesa package
                                                 #:driver %nvidia-driver))
                                 wine-game-packages)
                            (list %nvidia-driver)))
