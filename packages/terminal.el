(use-package vterm
  :defer t
  :ensure t
  :hook ((vterm-mode . (lambda () (interactive) (display-line-numbers-mode 0)))))

(use-package eshell
  :defer t
  :ensure t
  :init
  (setq
   eshell-scroll-to-bottom-on-input 'all
   eshell-error-if-no-glob t
   eshell-hist-ignoredups t
   eshell-save-history-on-exit t
   eshell-prefer-lisp-functions nil
   eshell-destroy-buffer-when-process-dies t)
  :config
  (add-hook 'eshell-mode-hook (lambda ()
                                (eshell/alias "e" "find-file $1")
                                (eshell/alias "ff" "find-file $1")
                                (eshell/alias "emacs" "find-file $1")
                                (eshell/alias "ee" "find-file-other-window $1")
                                (eshell/alias "gd" "magit-diff-unstaged")
                                (eshell/alias "gds" "magit-diff-staged")
                                (eshell/alias "d" "dired $1")
                                (let ((ls (if (file-exists-p "/opt/homebrew/bin/gls")
                                              "/opt/homebrew/bin/gls"
                                            "/Users/ayushjha/.cargo/bin/exa")))
                                  (eshell/alias "ll" (concat ls " -AlohG --color=always")))))
  (add-hook 'eshell-mode-hook
            (lambda ()
              (add-to-list 'eshell-visual-commands "ssh")
              (add-to-list 'eshell-visual-commands "tail")
              (add-to-list 'eshell-visual-commands "top"))))

(use-package eshell-syntax-highlighting
  :ensure t
  :after esh-mode
  :demand t
  :config
  (eshell-syntax-highlighting-global-mode +1))


(use-package geiser :ensure t)
