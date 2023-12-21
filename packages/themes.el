(use-package doom-themes :ensure t)
(use-package ef-themes :ensure t)

(use-package circadian
  :ensure t
  :after (doom-themes ef-themes)
  :config
  (setq circadian-themes '(("7:00" . ef-tritanopia-light)
                           ("17:00" . doom-xcode)))
  (circadian-setup))

(use-package nyx-theme  :ensure )

(use-package hima-theme :ensure t)

(use-package tao-theme
  :ensure t)
