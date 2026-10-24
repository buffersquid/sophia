(define-module (sophia packages rust-apps)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix build-system cargo)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (sophia packages rust-crates)
  #:use-module (gnu packages rust)
  #:export (kdlfmt))

(define-public kdlfmt
  (package
   (name "kdlfmt")
   (version "0.1.7")
   (source
    (origin
     (method url-fetch)
     (uri (crate-uri "kdlfmt" version))
     (file-name (string-append name "-" version ".tar.gz"))
     (sha256
      (base32 "1vhxhd0g055njz1cj14i8qjba1ilivw94d76558469gw0xgdgrdc"))))
   (build-system cargo-build-system)
   (arguments
    (list
     #:install-source? #f
     #:rust rust-1.95))
   (inputs
    (cargo-inputs 'kdlfmt
                  #:module '(sophia packages rust-crates)))
   (home-page "https://github.com/hougesen/kdlfmt")
   (synopsis "A formatter for kdl documents")
   (description
    "Kdlfmt is a command-line formatter for KDL documents.  It supports
KDL version 1 and version 2, and provides commands to format documents,
check formatting, initialize configuration, and generate shell
completions")
   (license license:expat)))

