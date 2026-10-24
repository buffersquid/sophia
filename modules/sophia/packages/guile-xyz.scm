(define-module (sophia packages guile-xyz)
  #:use-module (guix packages)
  #:use-module (guix gexp)
  #:use-module (guix git-download)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix build-system gnu)
  #:use-module (gnu packages autotools)
  #:use-module (gnu packages guile)
  #:use-module (gnu packages pkg-config))

(define-public guile-schemefmt
  (package
   (name "guile-schemefmt")
   (version "0.0.0")
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
           (url "https://git.sr.ht/~campbellr/guile-schemefmt")
           (commit "e732d99c92bb71586c771cf3f55e7dc468a811b4")))
     (file-name (git-file-name name version))
     (sha256
      (base32 "07ma2cjqf73p3lqyibgvkp4mb8r10ag22h0gka75c11m025va7j9"))))
   (build-system gnu-build-system)
   (native-inputs
    (list autoconf automake pkg-config guile-next))
   (synopsis "Scheme source formatter, port of Emacs scheme-mode")
   (description
    "guile-schemefmt is a command-line filter and Guile library that
re-indents Scheme source code to match the output of Emacs'
@code{scheme-mode}.  The algorithm is a direct port of
@code{scheme.el} and @code{lisp-mode.el}, so a project's
@code{scheme-indent-function} rules can be expressed in a small
native config file (@file{.lispwords}) and fed to the tool for
per-project customisation.  Suitable for use as a Vim
@code{equalprg} filter, a pre-commit formatter, or a library
callable from the Guile REPL.")
   (home-page "https://git.sr.ht/~campbellr/guile-schemefmt")
   (license license:gpl3+)))

