(define-module (sophia packages rust-apps)
  #:use-module (guix gexp)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module (guix build-system cargo)
  #:use-module ((guix licenses)
                #:prefix license:)
  #:use-module (sophia packages rust-crates)
  #:use-module (gnu packages rust)
  #:export (kdlfmt))

(define-public kdlfmt
  (package
    (name "kdlfmt")
    (version "0.1.7")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/hougesen/kdlfmt")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "16321b0ilzjr08a4a85r0bw3jmma1hanfff5ld7rn4rv0bidzp0n"))))
    (build-system cargo-build-system)
    (arguments
     (list
      #:install-source? #f
      #:rust rust-1.95
      #:cargo-install-paths ''("cli")
      #:phases
      #~(modify-phases %standard-phases
          (add-after 'unpack-rust-crates 'remove-prebuilt-files
            (lambda _
              (for-each delete-file
                        (find-files "guix-vendor"
                                    "\\.(a|dll|dylib|exe|lib|o|so)$")) #t)))))
    (inputs (cargo-inputs 'kdlfmt
                          #:module '(sophia packages rust-crates)))
    (home-page "https://github.com/hougesen/kdlfmt")
    (synopsis "KDL document formatter")
    (description
     "Kdlfmt is a command-line formatter for KDL documents.  It supports
KDL version 1 and version 2, and provides commands to format documents,
check formatting, initialize configuration, and generate shell
completions.")
    (license license:expat)))

