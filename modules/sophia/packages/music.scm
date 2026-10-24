;;; GNU Guix --- Functional package management for GNU
;;; Copyright © 2026

(define-module (sophia packages music)
  #:use-module (guix gexp)
  #:use-module (guix utils)
  #:use-module (guix packages)
  #:use-module ((suika-chan packages spotify)
                #:prefix suika:))

(define-public spotify
  (package
    (inherit suika:spotify)
    (arguments
     (substitute-keyword-arguments (package-arguments suika:spotify)
       ((#:phases phases)
        #~(modify-phases #$phases
            
            ;; Install the desktop entry where application launchers
            ;; such as Fuzzel expect to find it.
            (add-after 'install 'install-desktop-entry
              (lambda* (#:key outputs #:allow-other-keys)
                (let* ((out (assoc-ref outputs "out"))
                       (source (string-append out
                                "/usr/share/spotify/spotify.desktop"))
                       (directory (string-append out "/share/applications"))
                       (desktop (string-append directory "/spotify.desktop"))
                       (icons (string-append out "/usr/share/spotify/icons")))
                  
                  ;; Install and fix the desktop entry.
                  (unless (file-exists? source)
                    (error "Spotify desktop entry not found:" source))
                  (mkdir-p directory)
                  (copy-file source desktop)

                  (substitute* desktop
                    (("^Exec=.*")
                     (string-append "Exec=" out "/bin/spotify --uri=%u\n"))
                    (("^TryExec=.*")
                     (string-append "TryExec=" out "/bin/spotify\n"))
                    (("^Icon=.*")
                     "Icon=spotify\n"))

                  ;; Install icons into the standard hicolor theme.
                  (for-each (lambda (size)
                              (let ((icon-source (string-append icons
                                                  "/spotify-linux-" size
                                                  ".png"))
                                    (icon-directory (string-append out
                                                     "/share/icons/hicolor/"
                                                     size
                                                     "x"
                                                     size
                                                     "/apps")))
                                (unless (file-exists? icon-source)
                                  (error "Spotify icon not found:" icon-source))
                                (mkdir-p icon-directory)
                                (copy-file icon-source
                                           (string-append icon-directory
                                                          "/spotify.png"))))
                            '("22" "24"
                              "32"
                              "48"
                              "64"
                              "128"
                              "256"
                              "512"))

                  #t)))

            ;; Fix the ELF interpreter for Guix System.
            (add-after 'install-desktop-entry 'patch-spotify-interpreter
              (lambda* (#:key inputs outputs #:allow-other-keys)
                (let* ((out (assoc-ref outputs "out"))
                       (binary (string-append out "/usr/share/spotify/spotify"))
                       (libc (assoc-ref inputs "libc"))
                       (loader (car (find-files libc "ld-linux.*\\.so"))))
                  (unless (file-exists? binary)
                    (error "Spotify binary not found:" binary))
                  (make-file-writable binary)
                  (invoke "patchelf" "--set-interpreter" loader binary)
                  (format #t "Patched interpreter: ~a~%" loader) #t)))))))))
