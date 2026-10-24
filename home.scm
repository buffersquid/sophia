(use-modules (guix gexp)
             (gnu home)
             (gnu packages)
             (gnu services)
             (sophia config)
             (gnu packages vim)
             (gnu packages tmux)
             (gnu packages ssh)
             (gnu packages version-control)
             (gnu packages gnupg)
             (nongnu packages mozilla)
             (nongnu packages nvidia)
             (sophia packages desktop)
             (sophia packages music)
             (gnu home services gnupg)
             (gnu home services ssh)
             (gnu home services sound)
             (gnu home services desktop)
             (gnu home services shells))

(home-environment
  (packages (list niri-desktop
                  git
                  neovim
                  tmux
                  openssh
                  gnupg
                  (replace-mesa firefox
                                #:driver %nvidia-driver)
                  spotify))

  (services
   (append (list (service home-bash-service-type
                          (home-bash-configuration
                           (guix-defaults? #t)))
                 (service home-dbus-service-type)
                 (service home-pipewire-service-type)
                 (service home-ssh-agent-service-type)
                 (service home-gpg-agent-service-type
                          (home-gpg-agent-configuration (pinentry-program (file-append
                                                                           pinentry-qt
                                                                           "/bin/pinentry-qt"))
                                                        (ssh-support? #f))))
           %base-home-services)))
