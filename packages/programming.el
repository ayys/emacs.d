(use-package lsp-mode :ensure t)
(use-package lsp-python-ms
  :ensure t
  :hook (python-mode . (lambda ()
                         (require 'lsp-python-ms)
                         (lsp))))
(use-package  lsp-ui :ensure t  :commands lsp-ui-mode)
(use-package lsp-ivy :ensure t   :commands lsp-ivy-workspace-symbol)
(use-package lsp-treemacs :ensure t  :commands lsp-treemacs-errors-list)

(use-package fixmee
  :hook (prog-mode . fixmee-mode)
  :ensure t
  :config
  (require 'button-lock))
;; (use-package realgud :ensure t)
(use-package web-mode :ensure t)

(use-package copilot

  :load-path (lambda () (expand-file-name "copilot.el" user-emacs-directory))
  ;; don't show in mode line
  :diminish
  :hook
  ((prog-mode . copilot-mode)
   (org-mode . copilot-mode)
   (markdown-mode . copilot-mode))
  :config
  (define-key copilot-completion-map (kbd "<tab>") 'copilot-accept-completion)
  (define-key copilot-completion-map (kbd "TAB") 'copilot-accept-completion))


(use-package sqlformat
  :ensure t
  :hook ((sql-mode . sqlformat-on-save-mode))
  :config
  (setq sqlformat-command 'pgformatter)
  (setq sqlformat-args '("--format-type")))

(use-package separedit
  :bind ("C-c '" . separedit)
  :ensure t
  :config
  (progn
    (setq separedit-default-mode 'markdown-mode)))


(use-package helm-template-mode
  :mode ("\\.tpl\\'" . helm-template-mode)
  :load-path (lambda () (expand-file-name "helm-template-mode" user-emacs-directory)))

(use-package pyvenv
  :defer t
  :ensure t
  :init
  (setenv "WORKON_HOME" "/Users/ayushjha/Library/Caches/pypoetry/virtualenvs"))


(use-package yasnippet

  :ensure t
  :config (yas-load-directory "~/.emacs.d/snippets")
  :hook ( prog-mode . yas-minor-mode ))

(use-package rustic
  :ensure t
  :bind (:map rustic-mode-map
              ("M-j" . lsp-ui-imenu)
              ("M-?" . lsp-find-references)
              ("C-c C-c a" . lsp-execute-code-action)
              ("C-c C-c r" . lsp-rename)
              ("C-c C-c q" . lsp-workspace-restart)
              ("C-c C-c Q" . lsp-workspace-shutdown)
              ("C-c C-c s" . lsp-rust-analyzer-status))
  :config
  (setq rustic-format-on-save t)
  ;; :hook
  ;; (rustic-mode . 'rk/rustic-mode-hook)
  ; (add-hook 'rustic-mode-hook 'rk/rustic-mode-hook)
  :custom
  (rustic-rustfmt-config-alist '((edition . "2021"))))

(use-package highlight-indent-guides

  :ensure t
  :hook ( prog-mode . highlight-indent-guides-mode )
  :config
  (setq highlight-indent-guides-method 'character)
  (setq highlight-indent-guides-character ?\|)
  (setq highlight-indent-guides-auto-enabled t))

(use-package tree-sitter :ensure t)
(use-package tree-sitter-langs
  :ensure t
  :after tree-sitter)
