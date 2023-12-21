(use-package counsel
  :ensure t
  :after ivy
  :bind (("C-c C-g" . counsel-git-grep))
  :config (counsel-mode))

(use-package drag-stuff

  :ensure t
  :hook (prog-mode . drag-stuff-mode )
  :bind (("M-p" . drag-stuff-up)
	 ("M-n" . drag-stuf-down)))

(use-package expand-region
  :ensure t
  :bind (("C-=" . er/expand-region)
         ("C--" . er/contract-region)))

(use-package highlight-symbol

  :ensure t
  :bind (("C-c C-n" . highlight-symbol-next)
	 ("C-c r" . highlight-symbol-query-replace)
	 ("C-c C-b" . highlight-symbol-prev)))

(use-package ivy
  :ensure t

  :diminish
  :config
  (progn
    (setq ivy-initial-inputs-alist nil)
    (setq ivy-use-virtual-buffers t)
    (setq ivy-count-format "(%d/%d) ")
    (setq ivy-re-builders-alist
          '((ivy-switch-buffer . ivy--regex-plus)
            (swiper . ivy--regex-plus)
            (counsel-M-x . ivy--regex)
            (t . ivy--regex-plus))))
  :bind (("C-c C-r" . ivy-resume)
         ("C-x B" . ivy-switch-buffer-other-window))
  :custom
  (ivy-count-format "(%d/%d) ")
  (ivy-use-virtual-buffers t)
  :config (ivy-mode))

(use-package ivy-rich
  :ensure t
  :init
  (ivy-rich-mode 1))

(use-package multiple-cursors

  :ensure t
  :bind
  (("C-c m w" . mc/mark-all-symbols-like-this)
   ("C-c m e" . mc/edit-lines)
   ("C-c m r" . mc/mark-all-like-this)))

(use-package swiper

  :ensure t
  :after ivy
  :bind (("C-s" . swiper)
         ("C-r" . swiper)))

(use-package which-key
  :ensure t
  :config
  (which-key-mode))
