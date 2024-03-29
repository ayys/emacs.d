(defun open-project-readme ()
  "Open the README.md file in the project root, ignoring case."
  (let ((root (projectile-project-root)))
    (when root
      (let ((readme (car (directory-files root t "\\`README\\.md\\'" t))))
        (when readme
          (find-file readme))))))



(use-package projectile
  :ensure t
  :after vertico
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :bind (("C-c C-f" . projectile-find-file)
         ("C-c -" . projectile-run-async-shell-command-in-root))
  :config
  (progn
    (projectile-mode +1)
    (setq projectile-sort-order 'recently-active)
    (setq projectile-indexing-method 'hybrid)

    (setq projectile-switch-project-action #'magit-status)
    (setq projectile-completion-system 'default)
    (setq projectile-project-search-path '("~/git" "~/go/src/"))))



(use-package treemacs
  :ensure t

  :init
  (with-eval-after-load 'winum
    (define-key winum-keymap (kbd "M-0") #'treemacs-select-window))
  :config
  (progn
    (define-key treemacs-mode-map [mouse-1] #'treemacs-single-click-expand-action)
    (treemacs-filewatch-mode t)
    (treemacs-fringe-indicator-mode 'always)
    (pcase (cons (not (null (executable-find "git")))
                 (not (null treemacs-python-executable)))
      (`(t . t)
       (treemacs-git-mode 'deferred))
      (`(t . _)
       (treemacs-git-mode 'simple)))
    (treemacs-follow-mode t)
    (setq treemacs-follow-after-init          t
          treemacs-width                      35
          treemacs-indentation                2
          treemacs-git-integration            t
          treemacs-collapse-dirs              3
          treemacs-silent-refresh             t
          treemacs-change-root-without-asking nil
          treemacs-sorting                     'alphabetic-desc
          treemacs-show-hidden-files           t
          treemacs-never-persist               nil
          treemacs-is-never-other-window       nil
          treemacs-width-is-initially-locked   -1
          treemacs-goto-tag-strategy           'refetch-index)
    ):bind
  (:map global-map
        ("M-0"       . treemacs-select-window)
        ("C-x t 1"   . treemacs-delete-other-windows)
        ("C-x t t"   . treemacs)
        ("C-x t B"   . treemacs-bookmark)
        ("C-x t C-t" . treemacs-find-file)
        ("C-x t M-t" . treemacs-find-tag)))

(use-package treemacs-persp

  :after (treemacs persp-mode)
  :ensure t
  :config (treemacs-set-scope-type 'Perspectives))
