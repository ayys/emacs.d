(setq byte-compile-warnings '(cl-functions))
(setq message-log-max t)
(savehist-mode 1)
(global-subword-mode)
(set-default 'cursor-type 'bar)

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file)

(setenv "PATH" (concat (getenv "PATH") "/opt/homebrew/bin"))

(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)


;; Bootstrap 'use-package'
(eval-after-load 'gnutls
  '(add-to-list 'gnutls-trustfiles "/etc/ssl/cert.pem"))
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile
(require 'use-package))
(require 'bind-key)
(setq use-package-always-ensure t)


(add-hook 'before-save-hook
          'delete-trailing-whitespace)
(add-hook 'prog-mode
          'electric-pair-mode)
(add-hook 'prog-mode 'display-line-number-mode)

(setq mac-command-modifier 'meta)
(setq mac-option-modifier 'super) ; make opt key do Super
(setq ns-function-modifier 'hyper)  ; make Fn key do Hyper
(setq create-lockfiles nil)
(setq initial-scratch-message "")
(setq mouse-wheel-progressive-speed nil)
(setq redisplay-dont-pause t)
(setq initial-major-mode 'org-mode)
(setq mouse-wheel-scroll-amount '(1))

(setq ispell-program-name (executable-find "hunspell")
      ispell-dictionary "en_US-large")
(setq-default line-spacing 2)
(setq org-startup-indented t
      org-pretty-entities t
      org-hide-emphasis-markers t
      org-startup-with-inline-images t
      org-image-actual-width '(300))
(setq ispell-program-name "/opt/homebrew/bin/aspell")
(setq flyspell-default-dictionary "en_US")
(setq ispell-dictionary flyspell-default-dictionary)

(delete-selection-mode t)
(put 'dired-find-alternate-file 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)


(defun org-insert-backtick ()
  "Insert a backtick using `org-self-insert-command'."
  (interactive)
  (setq last-command-event ?`)
  (call-interactively #'org-self-insert-command))

(defun org-insert-tilde ()
  "Insert a tilde using `org-self-insert-command'."
  (interactive)
  (setq last-command-event ?~)
  (call-interactively #'org-self-insert-command))

(defun revert-buffer-no-confirm ()
  "Revert buffer without confirmation."
  (interactive)
  (revert-buffer :ignore-auto :noconfirm))
(defun toggle-comment-on-line ()
  "COMMENT OR UNCOMMENT CURRENT LINE."
  (interactive)
  (comment-or-uncomment-region (line-beginning-position) (line-end-position)))

(defun copy-file-path-and-line-number-at-point ()
  "Copy the current buffer file name and line number at point to the clipboard."
  (interactive)
  (let ((file-path-and-line-number (format "%s::%d" (buffer-file-name) (line-number-at-pos))))
    (kill-new file-path-and-line-number)
    (message "Copied '%s'" file-path-and-line-number)))

(global-set-key (kbd "C-'") 'load-theme)
(global-set-key (kbd "C-c C-l") 'copy-file-path-and-line-number-at-point)
(global-set-key (kbd "C-:") 'goto-line)
(global-set-key (kbd "C-c C-m") 'projectile-compile-project)
(global-set-key (kbd "C-;") 'toggle-comment-on-line)
(global-set-key (kbd "C-\"") 'disable-theme)
(global-set-key (kbd "C-c C-/") 'revert-buffer-no-confirm)
(global-set-key (kbd "C-c C-b")  'bookmark-set)
(global-set-key (kbd "C-c C-q")  'run-previous-comamnd-in-eshell)
(global-set-key (kbd "C-c C-r") 'replace-string)
(global-set-key (kbd "C-c C-s") 'rgrep)
(global-set-key (kbd "C-c I") 'irc)
(global-set-key (kbd "M-s") 'avy-goto-char-timer)
(global-set-key [C-mouse-wheel-down-event] 'text-scale-decrease)
(global-set-key [C-mouse-wheel-up-event]  'text-scale-increase)
(global-set-key [double-wheel-down] 'up-double)
(global-set-key [double-wheel-up] 'down-double)
(global-set-key [triple-wheel-down] 'up-triple)
(global-set-key [triple-wheel-up] 'down-triple)
(global-set-key [wheel-down] 'up-single)
(global-set-key [wheel-up] 'down-single)
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.js\\'" . js-ts-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-ts-mode))
(add-to-list 'auto-mode-alist '("\\.rs\\'" . rustic-mode))
(add-to-list 'auto-mode-alist '("\\.rest\\'" . restclient-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-ts-mode))
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . typescript-ts-mode))
(add-to-list 'auto-mode-alist '("\\.oरग\\'" . org-mode))
(add-to-list 'auto-mode-alist '("build.gradle" . groovy-mode))
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")

(load "~/.emacs.d/load-directory.el")
(load-directory "~/.emacs.d/packages")


(defun configure-font ()
  "Configure font given initial non-daemon FRAME.
Intended for `after-make-frame-functions'."
  (interactive)
  (progn
      (set-frame-font "-*-PT Mono-regular-normal-normal-*-14-*-*-*-p-0-iso10646-1" nil t)))


(configure-font)
(add-hook 'after-make-frame-functions #'configure-font)

(load-file "~/.emacs.d/navapali-maps.el")

(ido-mode nil)  ;;  disable ido mode because it is annoying
