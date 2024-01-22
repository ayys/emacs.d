(use-package all-the-icons
  :ensure t)

(use-package better-defaults
  :ensure t )

(use-package dashboard
  :ensure t
  :config
  (setq dashboard-banner-logo-title "าयउ ऽकषउ")
  (setq dashboard-startup-banner "/Users/ayushjha/Pictures/dashboard_pic.png")
  (setq dashboard-set-heading-icons t)
  (setq dashboard-items '((projects . 5)
                          (bookmarks . 5)))
  (setq initial-buffer-choice (lambda () (get-buffer "*dashboard*")))
  (dashboard-setup-startup-hook))

(use-package ibuffer
  :bind (("C-x C-b" . ibuffer))
  :ensure t
  :config
  (progn
    (setq ibuffer-default-sorting-mode 'major-mode)
    (setq ibuffer-expert t)
    (use-package ibuffer-vc
      :ensure t
      :config
      (progn
        (defun modi/ibuffer-customization ()
          (ibuffer-vc-set-filter-groups-by-vc-root)
          (unless (eq ibuffer-sorting-mode 'alphabetic)
            (ibuffer-do-sort-by-alphabetic)
            (ibuffer-do-sort-by-major-mode)))))
    (add-hook 'ibuffer-hook #'modi/ibuffer-customization)))

(use-package disable-mouse

  :ensure t
  :hook (vterm-mode . disable-mouse-mode))

(use-package nyan-mode :ensure t
  :hook ((fundamental-mode . nyan-mode))
  :config
  (nyan-start-animation))

(use-package nerd-icons  :ensure t)

(use-package focus
  :ensure t)

(use-package eyebrowse
  :ensure t
  :config
  (eyebrowse-mode t)
  (setq eyebrowse-new-workspace t)
  (setq eyebrowse-wrap-around t)
  (setq eyebrowse-mode-line-style 'always)
  :bind (("M-1" . eyebrowse-switch-to-window-config-1)
         ("M-2" . eyebrowse-switch-to-window-config-2)
         ("M-3" . eyebrowse-switch-to-window-config-3)
         ("M-4" . eyebrowse-switch-to-window-config-4)
         ("M-5" . eyebrowse-switch-to-window-config-5)
         ("M-6" . eyebrowse-switch-to-window-config-6)
         ("M-7" . eyebrowse-switch-to-window-config-7)
         ("M-8" . eyebrowse-switch-to-window-config-8)
         ("M-9" . eyebrowse-switch-to-window-config-9)
         ("M-0" . eyebrowse-switch-to-window-config-0)
         ("C-c =" . eyebrowse-rename-window-config)
         ("C-c +" . eyebrowse-last-window-config)
         ("C-c _" . eyebrowse-close-window-config)
         ("C-c `" . eyebrowse-switch-to-window-config))
 )


(use-package centered-window :ensure t
  :init
  :config
  (setq cwm-use-vertical-padding nil)
  (setq cwm-frame-internal-border 0))


(use-package powerline
  :config (progn
            (setq powerline-arrow-shape 'arrow14)   ;; give your mode-line curves
            (setq powerline-image-apple-rgb t)
            (setq-default
             mode-line-format
             '("%e"
               (:eval
                (let ((active (powerline-selected-window-active)))
                  (powerline-simple-buffer active)
                  (powerline-simple-major-mode active)
                  (powerline-row active 'r)))))
            (powerline-default-theme))
  :ensure t)


(use-package diminish
  :ensure t
  :config
  (progn
    (diminish 'abbrev-mode nil)
    (diminish 'auto-revert-mode nil)
    (diminish 'eldoc-mode nil)
    (diminish 'flyspell-mode nil)
    (diminish 'global-whitespace-mode nil)
    (diminish 'helm-mode "Hm")
    (diminish 'ivy-mode nil)
    (diminish 'projectile-mode nil)
    (diminish 'counsel-mode nil)
    (diminish 'rainbow-mode nil)
    (diminish 'undo-tree-mode nil)
    (diminish 'company-mode "Cp")
    (diminish 'tree-sitter-mode "Ts")
    (diminish 'copile-mode "Co")
    (diminish 'visual-line-mode nil)
    (diminish 'whitespace-mode nil)
    (diminish 'rustic-mode "Rs")
    (diminish 'fixmee-mode nil)
    (diminish 'flymake-mode "FM")
    (diminish 'python-ts-mode "Py")
    (diminish 'python-mode "Py")
    (diminish 'lsp-lens-mode "L")
    (diminish 'ruff-format-on-save-mode nil)
    (diminish 'drag-stuff-mode nil)
    (diminish 'yas-minor-mode nil)))


(use-package tree-sitter
  :ensure t
  :hook ((prog-mode . tree-sitter-mode)
         (tree-sitter-after-on . tree-sitter-hl-mode)))

(use-package tree-sitter-langs
  :ensure t)


;; (use-package pixel-scroll
;;   :ensure nil
;;   :bind
;;   ([remap scroll-up-command]   . pixel-scroll-interpolate-down)
;;   ([remap scroll-down-command] . pixel-scroll-interpolate-up)
;;   :custom
;;   (pixel-scroll-precision-interpolate-page t)
;;   :init
;;   (pixel-scroll-precision-mode 0))
