(use-package treesit-auto
  :custom
  (treesit-auto-install 'prompt)
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))



(use-package lsp-mode :ensure t
  :bind (("M-." . lsp-find-definition)
         ("M-?" . lsp-find-references))
  )


(defun ayys/py-workon-project-venv ()
  "Activate the first .venv virtual environment found in the Projectile project."
  (let ((venv-path (directory-files-recursively (projectile-project-root) "^\.venv$" :include-directories t)))
    (if (and venv-path (file-directory-p (car venv-path)))
        (progn
          (pyvenv-activate (car venv-path))
          (car venv-path))
      (pyvenv-deactivate)
      nil)))

(defun ayys/py-auto-lsp ()
  "Turn on lsp mode in a Python project with some automated logic.
Try to automatically determine which pyenv virtual environment to
activate based on the project name, using
`ayys/py-workon-project-venv'. If successful, call `lsp'. If we
cannot determine the virtualenv automatically, first call the
interactive `pyvenv-activate' function before `lsp'"
  (interactive)

  (let ((pvenv (if (and (boundp 'pyvenv-virtual-env-name) pyvenv-virtual-env-name)
                   pyvenv-virtual-env-name
                 (ayys/py-workon-project-venv))))
    (if pvenv
        (lsp)
      (progn
        (call-interactively #'pyvenv-activate)
        (lsp)))))

(use-package lsp-python-ms
  :ensure t

  :hook ((python-mode . (lambda ()
                         (require 'lsp-python-ms)
                         (ayys/py-auto-lsp)))
         (python-ts-mode . (lambda ()
                         (require 'lsp-python-ms)
                         (ayys/py-auto-lsp)))))
(use-package  lsp-ui :ensure t  :commands lsp-ui-mode)
(use-package lsp-treemacs :ensure t  :commands lsp-treemacs-errors-list)


(use-package ruff-format :ensure t

  :hook (python-mode . ruff-format-on-save-mode)
  (python-ts-mode . ruff-format-on-save-mode))

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
  ;; turn off
  (setq rustic-format-on-save nil)
  (setq lsp-inlay-hint-enable t)
  ;; :hook
  (rustic-mode . lsp-inlay-hints-mode)
  (rust-ts-mode . rustic-mode)
  :custom
  (rustic-rustfmt-config-alist '((edition . "2021"))))

;; (use-package highlight-indent-guides

;;   :ensure t
;;   :hook ( prog-mode . highlight-indent-guides-mode )
;;   :config
;;   (setq highlight-indent-guides-method 'character)
;;   (setq highlight-indent-guides-character ?\|)
;;   (setq highlight-indent-guides-auto-enabled t))

(use-package tree-sitter :ensure t

  :hook ((rust-ts-mode . tree-sitter-hl-mode) (python-ts-mode . tree-sitter-hl-mode) (rust-ts-mode . lsp-deferred) (python-ts-mode . lsp-deferred))

  :config (add-to-list 'tree-sitter-major-mode-language-alist '(python-ts-mode . python))
  (add-to-list 'tree-sitter-major-mode-language-alist '(rust-ts-mode . rust)))
(use-package tree-sitter-langs
  :ensure t
  :after tree-sitter)

(setq treesit-language-source-alist
      '((bash "https://github.com/tree-sitter/tree-sitter-bash")
	(cmake "https://github.com/uyha/tree-sitter-cmake")
	(css "https://github.com/tree-sitter/tree-sitter-css")
	(elisp "https://github.com/Wilfred/tree-sitter-elisp")
	(go "https://github.com/tree-sitter/tree-sitter-go")
	(html "https://github.com/tree-sitter/tree-sitter-html")
	(javascript "https://github.com/tree-sitter/tree-sitter-javascript" "master" "src")
	(json "https://github.com/tree-sitter/tree-sitter-json")
	(make "https://github.com/alemuller/tree-sitter-make")
	(markdown "https://github.com/ikatyang/tree-sitter-markdown")
	(python "https://github.com/tree-sitter/tree-sitter-python")
	(toml "https://github.com/tree-sitter/tree-sitter-toml")
	(tsx "https://github.com/tree-sitter/tree-sitter-typescript" "master" "tsx/src")
	(typescript "https://github.com/tree-sitter/tree-sitter-typescript" "master" "typescript/src")
	(yaml "https://github.com/ikatyang/tree-sitter-yaml")))
