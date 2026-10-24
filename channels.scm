(cons* (channel
        (name 'sophia)
        (url "https://github.com/buffersquid/sophia")
	(branch "main")
        (introduction
         (make-channel-introduction
          "4dcbd0dbc0fefe6d5ac1bf3fe1b2ef1f72816048"
          (openpgp-fingerprint
           "A3DE DE93 731C B351 C891  0815 E75A 2784 63DF 3FB2"))))
       (channel
        (name 'nonguix)
        (url "https://gitlab.com/nonguix/nonguix")
        (introduction
         (make-channel-introduction
          "897c1a470da759236cc11798f4e0a5f7d4d59fbc"
          (openpgp-fingerprint
           "2A39 3FFF 68F4 EF7A 3D29  12AF 6F51 20A0 22FB B2D5"))))
       (channel
        (name 'suika-chan)
        (url "https://github.com/bakospe/suika-chan"))
       %default-channels)
