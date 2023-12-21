(use-package org
  :ensure t
  :bind
  (("C-c C-x t". open-todo-list)
   ("C-c a" . org-todo-list)
   ("C-c C-h" . org-html-export-to-html)
   ("C-c l" . org-store-link))
  :hook ((org-mode . auto-fill-mode)
         (org-mode . display-fill-column-indicator-mode)
         )
  :config
  (defun open-todo-list () (interactive) (find-file-other-window (cdr (car (cdr (car bookmark-alist))))))
  (add-to-list 'org-latex-packages-alist
               '("AUTO" "babel" t ("pdflatex")))
  (define-key org-mode-map (kbd "`") #'org-insert-tilde)
  (define-key org-mode-map (kbd "~") #'org-insert-backtick)
  (define-key org-mode-map (kbd "C-c C-r") 'verb-command-map)
  (add-to-list 'org-latex-packages-alist
               '("AUTO" "polyglossia" t ("xelatex" "lualatex"))))

(use-package org-bullets
  :ensure t
  :hook (org-mode . org-bullets-mode))
(use-package org-appear
  :ensure t
  :hook (org-mode . org-appear-mode))
(use-package org-superstar
  :ensure t
  :hook (org-mode . org-superstar-mode)
  :config
  (setq org-superstar-special-todo-items t))
(use-package org-rainbow-tags :ensure t
  :hook ((org-mode . org-rainbow-tags-mode)))

(use-package markdown-mode

  :ensure t
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :hook ((org-mode . auto-fill-mode)
         (markdown-mode . auto-fill-mode)
         (org-mode . display-fill-column-indicator-mode)
         (markdown-mode . display-fill-column-indicator-mode))
  :init (setq markdown-command "multimarkdown")
  :config
  (setq markdown-fontify-code-blocks-natively t))
