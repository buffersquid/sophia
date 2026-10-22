(use-modules (gnu home)
             (gnu packages)
             (gnu services)
             (guix gexp)
             (gnu packages admin)
             (gnu packages vim)
             (gnu packages tmux)
             (gnu packages window-management)
             (gnu packages xdisorg)
             (gnu packages terminals)
	     (gnu packages ssh)
	     (gnu packages gnupg)
             (nongnu packages mozilla)
             (nongnu packages nvidia)
	     (gnu home services gnupg)
	     (gnu home services ssh)
             (gnu home services shells)
             (gnu home services niri))

(home-environment
  ;; Home packages need the NVIDIA EGL/GBM libraries grafted too; the system
  ;; NVIDIA transformation does not automatically rewrite Home package inputs.
  (packages (list (replace-mesa niri #:driver nvda-580)
		  noctalia-shell
		  neovim
		  tmux
		  openssh
		  gnupg
		  fuzzel
		  (replace-mesa firefox #:driver nvda-580)
		  alacritty))

  (services
   (append (list (service home-bash-service-type
                          (home-bash-configuration
			    (guix-defaults? #t)))
		 (service home-ssh-agent-service-type)
		 (service home-gpg-agent-service-type
			  (home-gpg-agent-configuration
			    (pinentry-program
			      (file-append pinentry-qt "/bin/pinentry-qt"))
			    (ssh-support? #f))))
           %base-home-services)))
