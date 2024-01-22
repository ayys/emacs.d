(use-package magit-delta
  :ensure t
  :hook (magit-mode . magit-delta-mode))

(use-package magit
  :ensure t

  :bind
  (("C-x m" . magit-diff-unstaged)
   ("C-x C-g" . magit-status-quick)
   ("C-x g" . magit-status)))

(defun my-fetch-all-forge-topics ()
  "Fetch all topics from the forge remote."
  (when (and (derived-mode-p 'forge-topic-mode)
             ;; Add any additional conditions to verify topic creation
             )
    (forge-pull)))


(use-package forge
  :ensure t
  :after magit
  :hook ((forge-post-mode . auto-fill-mode)
         (forge-post-mode . turn-on-flyspell)
         (forge-post-mode . my-fetch-all-forge-topics)
         (forge-post-mode . display-fill-column-indicator-mode)))

(use-package magit-todos
  :ensure t
  :after magit
  :config
  (magit-todos-mode))

(use-package treemacs-magit
  :after (treemacs magit)
  :ensure t )

(use-package blamer

  :ensure t
  :bind (("C-c i" . blamer-show-commit-info))
  :custom
  (blamer-idle-time 0.1)
  (blamer-min-offset 50)
  :custom-face
  (blamer-face ((t :foreground "#7a88cf"
                   :background nil
                   :height 0.9
                   :italic t)))
  :config
  (global-blamer-mode))


(use-package git-link
  :ensure t)
