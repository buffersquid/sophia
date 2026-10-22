(use-modules (gnu)
	     (nongnu packages linux)
	     (nongnu packages nvidia)
	     (nongnu system linux-initrd)
	     (nonguix transformations))
(use-service-modules cups desktop networking ssh xorg security-token)

(define nongnu-key (plain-file "non-guix.pub" "(public-key (ecc (curve Ed25519) (q #C1FD53E5D4CE971933EC50C9F307AE2171A2D3B52C804642A7A35F84F3A4EA98#)))"))

(define %base-os
  (operating-system
  (locale "en_US.utf8")
  (timezone "America/Los_Angeles")
  (keyboard-layout (keyboard-layout "us"))
  (host-name "sophia")

  (kernel linux)
  (initrd microcode-initrd)
  (firmware (list linux-firmware))

  (users (cons* (user-account
                  (name "nous")
                  (comment "Nous")
                  (group "users")
                  (home-directory "/home/nous")
                  (supplementary-groups '("wheel" "netdev" "audio" "video" "input")))
                %base-user-accounts))

  (bootloader (bootloader-configuration
                (bootloader grub-efi-bootloader)
                (targets (list "/boot/efi"))
                (keyboard-layout keyboard-layout)))
  (mapped-devices (list (mapped-device
                          (source (uuid
                                   "7dbeb462-6740-421f-8681-464c32af17f9"))
                          (target "cryptroot")
                          (type luks-device-mapping))))

  (file-systems (cons* (file-system
                         (mount-point "/boot/efi")
                         (device (uuid "5CFE-F441"
                                       'fat32))
                         (type "vfat"))
                       (file-system
                         (mount-point "/")
                         (device "/dev/mapper/cryptroot")
                         (type "ext4")
                         (dependencies mapped-devices)) %base-file-systems))

  (services
   (append (list (simple-service 'nonguix-substitutes guix-service-type
				 (guix-extension
				   (substitute-urls (list "https://substitutes.nonguix.org"))
				   (authorized-keys (list nongnu-key))))
		 (service dhcpcd-service-type)
                 (service ntp-service-type)
		 (service elogind-service-type)
		 (service pcscd-service-type))
           %base-services))

  (packages %base-packages)))

;; The machine has a GeForce GTX 1650 (Turing).  Use the Nonguix NVIDIA
;; driver stack with DRM modesetting enabled for Wayland compositors such as
;; Niri.  This also blacklists Nouveau to avoid both drivers claiming the GPU.
((nonguix-transformation-nvidia #:driver nvda-580)
 %base-os)
