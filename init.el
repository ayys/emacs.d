(setq gc-cons-threshold most-positive-fixnum)
(setq byte-compile-warnings '(cl-functions))
(setq message-log-max t)
(global-subword-mode)
(set-default 'cursor-type 'bar)
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))

(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

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


(add-to-list 'load-path "~/git/wc-mode")

;; (add-to-list 'load-path "~/git/typewriter-mode")

(add-hook 'before-save-hook
          'delete-trailing-whitespace)
(add-hook 'prog-mode
          'electric-pair-mode)
(add-hook 'prog-mode 'display-line-number-mode)
;; (custom-set-faces
;;  '(helm-posframe-border ((t (:background "#6272a4"))))
;;  '(ivy-posframe-border ((t (:background "#6272a4")))))

(setq mac-command-modifier 'meta)
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
(load custom-file)
(delete-selection-mode t)
(put 'dired-find-alternate-file 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(use-package better-defaults
  :ensure t )

(use-package magit-delta

  :ensure t
  :hook (magit-mode . magit-delta-mode))

(use-package centaur-tabs
  :ensure t
  :demand
  :config
  (progn
    (setq centaur-tabs-style "bar"
	  centaur-tabs-height 15
	  centaur-tabs-set-icons t
	  centaur-tabs-set-modified-marker t
	  centaur-tabs-show-navigation-buttons t
	  centaur-tabs-set-bar 'over
          centaur-tabs-cycle-scope 'tabs
	  x-underline-at-descent-line t)
    (centaur-tabs-headline-match)
    (centaur-tabs-enable-buffer-reordering)
    (setq centaur-tabs-adjust-buffer-order t)
    (centaur-tabs-mode t)
    (setq uniquify-separator "/")
    (setq uniquify-buffer-name-style 'forward)
    (centaur-tabs-group-by-projectile-project)
    )

  :hook
  ;; (dashboard-mode . centaur-tabs-local-mode)
  (term-mode . centaur-tabs-local-mode)
  (calendar-mode . centaur-tabs-local-mode)
  (org-agenda-mode . centaur-tabs-local-mode)
  (helpful-mode . centaur-tabs-local-mode)
  :bind
  ("C-S-<prior>" . centaur-tabs-forward-group)
  ("C-<prior>" . centaur-tabs-forward)
  ("C-S-<next>" . centaur-tabs-backward-group)
  ("C-<next>" . centaur-tabs-backward))
(use-package centered-window  :ensure t )

;; (use-package circadian
;;   :ensure t
;;   :config
;;   (setq circadian-themes '(("7:00" . hima)
;;                            ("17:00" . doom-xcode)))
;;   (circadian-setup))

(use-package company
  :ensure t
  :init
  (add-hook 'after-init-hook 'global-company-mode)
  :config
  (add-to-list 'company-backends 'company-clang)
  (setq company-minimum-prefix-length 2)
  (setq company-idle-delay 0))
;; (use-package company-jedi
;;   :ensure t
;;   :after company
;;   :bind (("C-." . jedi:goto-definition)
;;          ("C-," . jedi:goto-definition-pop-marker))
;;   :config
;;   (defun my/python-mode-hook ()
;;     (add-to-list 'company-backends 'company-jedi))
;;   (setq jedi:setup-keys t)
;;   (setq jedi:complete-on-dot t)
;;   (add-hook 'python-mode-hook 'my/python-mode-hook))
(use-package counsel
  :ensure t
  :after ivy
  :bind (("C-c C-g" . counsel-git-grep))
  :config (counsel-mode))
(use-package dashboard
  :ensure t
  :config
  (setq dashboard-banner-logo-title "าयउ ऽकशउ")
  (setq dashboard-startup-banner "/Users/ayushjha/Pictures/dashboard_pic.png")
  (setq dashboard-set-heading-icons t)
  (setq dashboard-items '((recents  . 5)
                          (bookmarks . 5)
                          (projects . 10)))
  (setq initial-buffer-choice (lambda () (get-buffer "*dashboard*")))
  (dashboard-setup-startup-hook)
  )

(use-package rcirc
  :ensure t
  :config
  (setq rcirc-server-alist
        '(("irc.libera.chat"
           :user "ays"
           :port 6697 :encryption tls
	   :channels ("#libera"))))
  )
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
  (add-hook 'rustic-mode-hook 'rk/rustic-mode-hook))
(use-package drag-stuff

  :ensure t
  :hook (prog-mode . drag-stuff-mode )
  :bind (("M-p" . drag-stuff-up)
	 ("M-n" . drag-stuf-down)))
(use-package fixmee
  :hook (prog-mode . fixmee-mode)
  :ensure t
  :config
  (require 'button-lock))
(use-package vterm
  :defer t
  :ensure t )

(use-package multi-vterm
  :ensure t
  :config
  (setq multi-vterm-dedicated-window-height-percent 30)
  :bind (("C-c s v" . multi-vterm-dedicated-toggle))
  )
(use-package disable-mouse

  :ensure t
  :hook (vterm-mode . disable-mouse-mode))
(use-package spaceline
  :hook ((prog-mode . spaceline-spacemacs-theme)
         (prog-mode . spaceline-helm-mode))
  :ensure t)
(use-package all-the-icons-dired
  :hook (dired-mode . all-the-icons-dired-mode)
  :ensure t)
;; (use-package wc-mode
;;   :ensure t)

(use-package nyan-mode :ensure t
  :hook ((fundamental-mode . nyan-mode))
  :config
  (spaceline-toggle-nyan-cat-on)
  (nyan-start-animation))

(defun cus-xref-find-definitions-at-mouse (event)
  "Find the definition of identifier at or around mouse click.
This command is intended to be bound to a mouse event."
  (interactive "e")
  (let ((identifier
         (save-excursion
           (mouse-set-point event)
           (xref-backend-identifier-at-point (xref-find-backend)))))
    (if identifier
        (xref-find-definitions identifier)
      (user-error "No identifier here"))))

(use-package eglot

  :ensure t
  :hook ((python-mode . eglot-ensure)
         (rust-mode . eglot-ensure))
  :config
  (load-file "~/.emacs.d/eglot-x.el")
  (define-key eglot-mode-map (kbd "C-<down-mouse-1>") #'xref-find-definitions)
  (define-key eglot-mode-map (kbd "C-<mouse-1>") #'xref-find-definitions))

(use-package dired
  :ensure f
  :hook (dired-mode . dired-hide-details-mode)
  :ensure nil
  :config
  (setq dired-dwim-target t)
  (use-package diredfl

    :ensure t
    :config
    (diredfl-global-mode 1))
  (define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file)
  (define-key dired-mode-map (kbd "\\") (lambda () (interactive) (find-alternate-file "..")))
  (define-key dired-mode-map (kbd ",") 'dired-hide-details-mode)
  (setq dired-recursive-copies (quote always))
  (setq dired-recursive-deletes (quote top)) ; “top” means ask once
  (when (string= system-type "darwin")
    (setq dired-use-ls-dired t
          insert-directory-program "/opt/homebrew/bin/gls"))
  :custom
  (dired-listing-switches "-aBhl --group-directories-first"))
(use-package dired-narrow

  :ensure t
  :bind (:map dired-mode-map
              ("/" . dired-narrow-regexp)))
(use-package dired-rainbow
  ;; :hook (dired-mode . dired-rainbow-mode)

  :ensure t
  :config
  (progn
    (dired-rainbow-define-chmod directory "#8AA6BF" "d.*")
    (dired-rainbow-define html "#C47891" ("css" "less" "sass" "scss" "htm" "html" "jhtm" "mht" "eml" "mustache" "xhtml"))
    (dired-rainbow-define xml "#536A89" ("xml" "xsd" "xsl" "xslt" "wsdl" "bib" "json" "msg" "pgn" "rss" "yaml" "yml" "rdata"))
    (dired-rainbow-define document "#A478A8" ("docm" "doc" "docx" "odb" "odt" "pdb" "pdf" "ps" "rtf" "djvu" "epub" "odp" "ppt" "pptx"))
    (dired-rainbow-define markdown "#AD5B8F" ("org" "etx" "info" "markdown" "md" "mkd" "nfo" "pod" "rst" "tex" "textfile" "txt"))
    (dired-rainbow-define database "#7688A2" ("xlsx" "xls" "csv" "accdb" "db" "mdb" "sqlite" "nc"))
    (dired-rainbow-define media "#CC6E51" ("mp3" "mp4" "MP3" "MP4" "avi" "mpeg" "mpg" "flv" "ogg" "mov" "mid" "midi" "wav" "aiff" "flac"))
    (dired-rainbow-define image "#C5727F" ("tiff" "tif" "cdr" "gif" "ico" "jpeg" "jpg" "png" "psd" "eps" "svg"))
    (dired-rainbow-define log "#AB8431" ("log"))
    (dired-rainbow-define shell "#E38752" ("awk" "bash" "bat" "sed" "sh" "zsh" "vim"))

    ;; Both Light and Dark Themes
    (dired-rainbow-define interpreted "#98B384" ("py" "ipynb" "rb" "pl" "t" "msql" "mysql" "pgsql" "sql" "r" "clj" "cljs" "scala" "js"))
    (dired-rainbow-define compiled "#99B8A0" ("asm" "cl" "lisp" "el" "c" "h" "c++" "h++" "hpp" "hxx" "m" "cc" "cs" "cp" "cpp" "go" "f" "for" "ftn" "f90" "f95" "f03" "f08" "s" "rs" "hi" "hs" "pyc" ".java"))
    (dired-rainbow-define executable "#A17FA7" ("exe" "msi"))
    (dired-rainbow-define compressed "#A39984" ("7z" "zip" "bz2" "tgz" "txz" "gz" "xz" "z" "Z" "jar" "war" "ear" "rar" "sar" "xpi" "apk" "xz" "tar"))
    (dired-rainbow-define packaged "#E3B170" ("deb" "rpm" "apk" "jad" "jar" "cab" "pak" "pk3" "vdf" "vpk" "bsp"))
    (dired-rainbow-define encrypted "#EDE356" ("gpg" "pgp" "asc" "bfe" "enc" "signature" "sig" "p12" "pem"))
    (dired-rainbow-define fonts "#8AA6BF" ("afm" "fon" "fnt" "pfb" "pfm" "ttf" "otf"))
    (dired-rainbow-define partition "#C9555B" ("dmg" "iso" "bin" "nrg" "qcow" "toast" "vcd" "vmdk" "bak"))
    (dired-rainbow-define vc "#6883A5" ("git" "gitignore" "gitattributes" "gitmodules"))
    (dired-rainbow-define-chmod executable-unix "#98B384" "-.*x.*")
    )

  )
(use-package dired-subtree :ensure t

  :after dired
  :config
  (bind-key "<tab>" #'dired-subtree-toggle dired-mode-map)
  (bind-key "<backtab>" #'dired-subtree-cycle dired-mode-map))

(use-package emmet-mode

  :ensure t
  :hook web-mode)
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
(use-package expand-region

  :ensure t
  :bind (("C-=" . er/expand-region)))

(use-package yaml-pro
  :mode (
         ("\\.yml\\'" . yaml-mode)
         ("\\.yaml\\'" . yaml-mode))
  :ensure t)

;; (use-package flycheck
;;   :ensure t
;;   :config
;;   (flycheck-add-mode 'typescript-tslint 'web-mode)
;;   (add-hook 'js2-mode-hook #'setup-tide-mode)
;;   (setq flycheck-checkers '(ada-gnat asciidoctor asciidoc awk-gawk bazel-buildifier c/c++-clang c/c++-gcc c/c++-cppcheck cfengine chef-foodcritic coffee coffee-coffeelint coq css-csslint css-stylelint cuda-nvcc cwl d-dmd dockerfile-hadolint elixir-credo emacs-lisp emacs-lisp-checkdoc ember-template erlang-rebar3 erlang eruby-erubis eruby-ruumba fortran-gfortran go-gofmt go-golint go-vet go-build go-test go-errcheck go-unconvert go-staticcheck groovy haml handlebars haskell-stack-ghc haskell-ghc haskell-hlint html-tidy javascript-eslint javascript-jshint javascript-standard json-jsonlint nil json-python-json json-jq jsonnet less less-stylelint llvm-llc lua-luacheck lua markdown-markdownlint-cli markdown-mdl nix nix-linter opam perl perl-perlcritic php php-phpmd php-phpcs processing proselint protobuf-protoc protobuf-prototool pug puppet-parser puppet-lint nil python-flake8 nil python-pylint nil python-pycompile nil python-mypy r-lintr racket rpm-rpmlint rst-sphinx rst ruby-rubocop ruby-standard ruby-reek ruby-rubylint ruby ruby-jruby rust-cargo rust rust-clippy scala scala-scalastyle scheme-chicken scss-lint scss-stylelint sass/scss-sass-lint sass scss sh-bash sh-posix-dash sh-posix-bash sh-zsh sh-shellcheck slim slim-lint sql-sqlint systemd-analyze tcl-nagelfar terraform terraform-tflint tex-chktex tex-lacheck texinfo textlint typescript-tslint verilog-verilator vhdl-ghdl xml-xmlstarlet xml-xmllint yaml-jsyaml yaml-ruby yaml-yamllint))
;;   (setq flycheck-flake8-maximum-line-length 150)
;;   :hook
;;   ( (c-mode) . flycheck-mode)
;;   (flycheck-mode . flycheck-indicator-mode))
;; (use-package flycheck-indicator
;;   :ensure t
;;   :hook (flycheck-mode . flycheck-indicator-mode))
(use-package go-mode
  :mode ("\\.go\\'" . go-mode)
  :ensure t
  :config
  (setenv "GOPROXY" "https://proxy.golang.org,direct")
  ;; (defun lsp-go-install-save-hooks ()
  ;;   (add-hook 'before-save-hook #'lsp-format-buffer t t)
  ;;   (add-hook 'before-save-hook #'lsp-organize-imports t t))
  ;; :hook
  ;; (( go-mode . lsp-deferred )
  ;;  ( go-mode . lsp-go-install-save-hooks ))
  )
(use-package hemera-theme  :ensure )
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


(defun my-file-permissions (candidate)
  (let ((attrs (file-attributes candidate)))
    (if (file-directory-p candidate)
        (format "d%s" (substring (nth 8 attrs) 1))
      (nth 8 attrs))))

(setq ivy-rich-display-transformers-list
      (plist-put ivy-rich-display-transformers-list
                 'counsel-find-file
                 '(:columns
                   ((ivy-read-file-transformer)
                    (my-file-permissions (:width 10))
                    (ivy-rich-candidate-size (:width 7))
                    (ivy-rich-file-last-modified-time (:width 20)))
                   :delimiter "\t")))


(use-package ivy-posframe

  :ensure t
  :config
  (setq ivy-posframe-parameters
        '((left-fringe . 10)
          (right-fringe . 5)))
  (setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-window-center)))
  (setq ivy-posframe-height-alist '((swiper . 15)
                                    (t      . 10)))
  (setq ivy-posframe-display-functions-alist
        '((swiper          . ivy-display-function-fallback)
          (t               . ivy-posframe-display-at-window-center)))
  :hook
  (ivy-mode . ivy-posframe-mode))
(use-package magit
  :ensure t

  :bind
  (("C-x m" . magit-diff-unstaged)
   ("C-x g" . magit-status))
  :config
  (add-to-list magit-status-sections-hook magit-insert-ignored-files))
(use-package forge

  :ensure t
  :after magit
  :hook ((forge-post-mode . auto-fill-mode)
         (forge-post-mode . display-fill-column-indicator-mode)
         (forge-post-mode . wc-mode))
  :config
  (forge-toggle-closed-visibility)
  )
(use-package markdown-mode

  :ensure t
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :hook ((org-mode . auto-fill-mode)
         (markdown-mode . auto-fill-mode)
         (org-mode . display-fill-column-indicator-mode)
         (markdown-mode . display-fill-column-indicator-mode)
         (org-mode . wc-mode)
         (markdown-mode . wc-mode))
  :init (setq markdown-command "multimarkdown")
  :config
  (setq markdown-fontify-code-blocks-natively t))

(use-package multiple-cursors

  :ensure t
  :bind
  (("C-c m w" . mc/mark-all-symbols-like-this)
   ("C-c m e" . mc/edit-lines)
   ("C-c m r" . mc/mark-all-like-this)))
(use-package nyx-theme  :ensure )
(use-package org
  :ensure t
  :bind
  (("C-c C-x t". open-todo-list))
  :config
  (defun open-todo-list () (interactive) (find-file-other-window (cdr (car (cdr (car bookmark-alist))))))
  (add-to-list 'org-latex-packages-alist
               '("AUTO" "babel" t ("pdflatex")))
  (define-key org-mode-map (kbd "C-c C-r") 'verb-command-map)
  (add-to-list 'org-latex-packages-alist
               '("AUTO" "polyglossia" t ("xelatex" "lualatex"))))
(use-package org
  :ensure t
  :config
  :hook ((org-mode . auto-fill-mode)
         (org-mode . display-fill-column-indicator-mode)
         (org-mode . wc-mode))
  :bind (("C-c a" . org-todo-list)
         ("C-c C-h" . org-html-export-to-html)
         ("C-c l" . org-store-link)))
(use-package paredit

  :ensure t
  :hook ( (scheme-mode  emacs-lisp-mode) . paredit-mode ))

(use-package prettier-js

  :ensure t
  :after angular-mode
  :init
  (add-hook 'angular-mode-hook 'prettier-js-mode)
  :config
  (setq prettier-js-args '("--trailing-comma" "all"
                           "--bracket-spacing" "false"))
  (defun enable-minor-mode (my-pair)
    "Enable minor mode if filename match the regexp.  MY-PAIR is a cons cell (regexp . minor-mode)."
    (if (buffer-file-name)
        (if (string-match (car my-pair) buffer-file-name)
            (funcall (cdr my-pair)))))
  (add-hook 'web-mode-hook #'(lambda ()
                               (enable-minor-mode
                                '("\\.jsx?\\'" . prettier-js-mode)))))
(use-package git-gutter

  :ensure t
  :after magit
  :config
  (add-hook 'prog-mode-hook 'git-gutter-mode))
(use-package projectile
  :ensure t

  :after ivy
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :bind (("C-c C-f" . projectile-find-file))
  :config
  (progn
    (projectile-mode +1)
    (setq projectile-sort-order 'recently-active)
    (setq projectile-indexing-method 'hybrid)
    (setq projectile-switch-project-action #'projectile-dired)
    (setq projectile-completion-system 'ivy)
    (setq projectile-project-search-path '("~/git" "~/go/src/"))))
(use-package py-isort

  :ensure t
  :after python
  :config
  (add-hook 'before-save-hook 'py-isort-before-save))
;; (use-package python-black
;;   :ensure t
;;   :demand t
;;   :config
;;   :hook
;;   (python-mode . python-black-on-save-mode-enable-dwim)
;;   (python-mode . python-black-on-save-mode)
;;   :after python)
(use-package pyvenv
  :defer t
  :ensure t
  :init
  (setenv "WORKON_HOME" "/Users/ayushjha/Library/Caches/pypoetry/virtualenvs"))
(use-package rainbow-delimiters

  :ensure t
  :hook ( prog-mode . rainbow-delimiters-mode ))
(use-package restclient

  :ensure t )
(use-package angular-mode

  ;; :config
  ;; (defun lsp-go-install-save-hooks ()
  ;;   (add-hook 'before-save-hook #'lsp-format-buffer t t)
  ;;   (add-hook 'before-save-hook #'lsp-organize-imports t t))
  ;; :hook
  ;; (( angular-mode . lsp-deferred )
  ;;  ( angular-mode . lsp-go-install-save-hooks ))
  :ensure t
  )
(use-package swiper

  :ensure t
  :after ivy
  :bind (("C-s" . swiper)
         ("C-r" . swiper)))
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
(use-package treemacs-icons-dired

  :after (treemacs dired)
  :ensure t
  :config (treemacs-icons-dired-mode))
(use-package treemacs-magit

  :after (treemacs magit)
  :ensure t )
(use-package treemacs-persp

  :after (treemacs persp-mode)
  :ensure t
  :config (treemacs-set-scope-type 'Perspectives))
(use-package treemacs-projectile

  :after (treemacs projectile)
  :ensure t )
(use-package windmove

  :ensure t
  :bind (("C-c h" . windmove-left)
	 ("C-c l" . windmove-right)
	 ("C-c k" . windmove-up)
	 ("C-c j" . windmove-down)))
(use-package yasnippet

  :ensure t
  :config (yas-load-directory "~/.emacs.d/snippets")
  :hook ( prog-mode . yas-minor-mode ))

(use-package company-posframe :ensure t )
(use-package lsp-mode :ensure t
  :hook (rust-mode . lsp))
;; (use-package lsp-python-ms
;;   :ensure t
;;   :hook (python-mode . (lambda ()
;;                          (require 'lsp-python-ms)
;;                          (lsp)))
;;   :init
;;   (setq lsp-python-ms-executable (executable-find "mspyls")))
(use-package  lsp-ui :ensure t  :commands lsp-ui-mode)
(use-package lsp-ivy :ensure t   :commands lsp-ivy-workspace-symbol)
(use-package lsp-treemacs :ensure t  :commands lsp-treemacs-errors-list)
(use-package which-key
  :ensure t
  :config
  (which-key-mode))
(add-function :after after-focus-change-function
              (defun me/garbage-collect-maybe ()
                (unless (frame-focus-state)
                  (garbage-collect))))
(put 'scroll-left 'disabled nil)
;; (org-babel-do-load-languages
;;  'org-babel-load-languages
;;  '((awk . t)))
;; (add-hook 'hack-local-variables-hook
;;           (lambda ()
;;             (when (derived-mode-p 'python-mode)
;;               (require 'lsp-python-ms)
;;               (lsp))))
(add-hook 'prog-mode-hook 'outline-minor-mode)
(add-hook 'prog-mode-hook 'display-fill-column-indicator-mode)
(add-hook 'prog-mode-hook 'hs-minor-mode)
;; (add-hook 'prog-mode-hook 'flyspell-prog-mode)
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

(global-set-key (kbd "C-'") 'load-theme)
(global-set-key (kbd "C-:") 'goto-line)
(global-set-key (kbd "C-;") 'toggle-comment-on-line)
(global-set-key (kbd "C-\"") 'disable-theme)
(global-set-key (kbd "C-c C-/") 'revert-buffer-no-confirm)
(global-set-key (kbd "C-c C-b")  'bookmark-set)
(global-set-key (kbd "C-c C-m")  'mingus)
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
(add-to-list 'auto-mode-alist '("\\.js\\'" . javascript-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-to-list 'auto-mode-alist '("\\.rest\\'" . restclient-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-mode))
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . angular-mode))
(add-to-list 'auto-mode-alist '("build.gradle" . groovy-mode))
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(setq org-agenda-files '("~/Library/Mobile Documents/iCloud~com~appsonthemove~beorg/Documents/org/todo.org" "~/Library/Mobile Documents/iCloud~com~appsonthemove~beorg/Documents/org/सक्यो.org"))
(defun unpackaged/sort-sexps (beg end)
  "Sort sexps in region.
Comments stay with the code below."
  (interactive "r")
  (cl-flet ((skip-whitespace ()
              (while (looking-at (rx (1+ (or space "\n"))))
                (goto-char (match-end 0))))
            (skip-both ()
              (while (cond ((or (nth 4 (syntax-ppss))
                                (ignore-errors
                                  (save-excursion
                                    (forward-char 1)
                                    (nth 4 (syntax-ppss)))))
                            (forward-line 1))
                           ((looking-at (rx (1+ (or space "\n"))))
                            (goto-char (match-end 0)))))))
    (save-excursion
      (save-restriction
        (narrow-to-region beg end)
        (goto-char beg)
        (skip-both)
        (cl-destructuring-bind (sexps markers)
            (cl-loop do (skip-whitespace)
                     for start = (point-marker)
                     for sexp = (ignore-errors
                                  (read (current-buffer)))
                     for end = (point-marker)
                     while sexp
                     collect (cons (buffer-substring (marker-position start) (marker-position end))
                                   (save-excursion
                                     (goto-char (marker-position start))
                                     (skip-both)
                                     (buffer-substring (point) (marker-position end))))
                     into sexps
                     collect (cons start end)
                     into markers
                     finally return (list sexps markers))
          (setq sexps (sort sexps (lambda (a b)
                                    (string< (cdr a) (cdr b)))))
          (cl-loop for (real . sort) in sexps
                   for (start . end) in markers
                   do (progn
                        (goto-char (marker-position start))
                        (insert-before-markers real)
                        (delete-region (point) (marker-position end)))))))))
(defun revert-buffer-no-confirm ()
  "Revert buffer without confirmation."
  (interactive)
  (revert-buffer :ignore-auto :noconfirm))
(defun toggle-comment-on-line ()
  "COMMENT OR UNCOMMENT CURRENT LINE."
  (interactive)
  (comment-or-uncomment-region (line-beginning-position) (line-end-position)))
(defun rk/rustic-mode-hook ()
  (when buffer-file-name
    (setq-local buffer-save-without-query t)))
(defun up-single () (interactive) (scroll-up 1))
(defun down-single () (interactive) (scroll-down 1))
(defun up-double () (interactive) (scroll-up 1))
(defun down-double () (interactive) (scroll-down 1))
(defun up-triple () (interactive) (scroll-up 1))
(defun down-triple () (interactive) (scroll-down 1))
(defun run-previous-comamnd-in-eshell (&optional eshell-buffer-name)
  (interactive)
  (if eshell-buffer-name (setq buffer-name eshell-buffer-name) (setq buffer-name "*eshell*"))
  (with-current-buffer buffer-name
    (eshell-return-to-prompt)
    (eshell-previous-matching-input-from-input 1)
    (eshell-send-input)))
;; (use-package server

;;   :ensure f
;;   :config
;;   (unless (server-running-p) (server-start)))
(setq org-confirm-babel-evaluate nil)
;; (load-file "~/.emacs.d/ob-rust.el")
;; (org-babel-do-load-languages
;;  'org-babel-load-languages '((C . t) (shell . t) (python .t) (rust . t)))
(use-package highlight-indent-guides

  :ensure t
  :hook ( prog-mode . highlight-indent-guides-mode )
  :config
  (setq highlight-indent-guides-method 'character)
  (setq highlight-indent-guides-character ?\|)
  (setq highlight-indent-guides-auto-enabled t))
;; (use-package svg-tag-mode
;;   :ensure t
;;   :hook ((prog-mode . svg-tag-mode) (org-mode . svg-tag-mode))
;;   :config
;;   (defconst date-re "[0-9]\\{4\\}-[0-9]\\{2\\}-[0-9]\\{2\\}")
;;   (defconst time-re "[0-9]\\{2\\}:[0-9]\\{2\\}")
;;   (defconst day-re "[A-Za-z]\\{3\\}")
;;   (defconst day-time-re (format "\\(%s\\)? ?\\(%s\\)?" day-re time-re))
;;   (setq svg-tag-tags
;;         `(
;;           (" :\\([a-zA-Z0-9\u0900-\u097F]+\\)" . ((lambda (tag) (svg-tag-make tag))))
;;           (" :\\([a-zA-Z0-9\u0900-\u097F]+[ \-]\\)" . ((lambda (tag) tag)))
;;           ("\\[#[a-zA-Z0-9\u0900-\u097F]+\\]" . ( (lambda (tag)
;;                                                     (svg-tag-make tag :face 'org-priority
;;                                                                   :beg 2 :end -1 :margin 0))))
;;           ("TODO" . ((lambda (tag) (svg-tag-make "TODO" :face 'org-todo :inverse t :margin 0))))
;;           (,(format "\\(<%s>\\)" date-re) .
;;            ((lambda (tag)
;;               (svg-tag-make tag :beg 1 :end -1 :margin 0))))
;;           (,(format "\\(<%s \\)%s>" date-re day-time-re) .
;;            ((lambda (tag)
;;               (svg-tag-make tag :beg 1 :inverse nil :crop-right t :margin 0))))
;;           (,(format "<%s \\(%s>\\)" date-re day-time-re) .
;;            ((lambda (tag)
;;               (svg-tag-make tag :end -1 :inverse t :crop-left t :margin 0))))
;;           (,(format "\\(\\[%s\\]\\)" date-re) .
;;            ((lambda (tag)
;;               (svg-tag-make tag :beg 1 :end -1 :margin 0 :face 'org-date))))
;;           (,(format "\\(\\[%s \\)%s\\]" date-re day-time-re) .
;;            ((lambda (tag)
;;               (svg-tag-make tag :beg 1 :inverse nil :crop-right t :margin 0 :face 'org-date))))
;;           (,(format "\\[%s \\(%s\\]\\)" date-re day-time-re) .
;;            ((lambda (tag)
;;               (svg-tag-make tag :end -1 :inverse t :crop-left t :margin 0 :face 'org-date)))))))
(defun magit-fetch-everything ()
  (if (vc-git-root default-directory)
      (with-temp-message "" (magit-fetch-all '()))))


(defun snake-to-camel ()
  "Convert symbol at point from snake_case to camelCase."
  (interactive)
  (let* ((bounds (bounds-of-thing-at-point 'symbol))
         (start (car bounds))
         (end (cdr bounds))
         (case-fold-search nil)
         (symbol (buffer-substring-no-properties start end)))
    (when (string-match "_" symbol)
      (let ((new-symbol (replace-regexp-in-string "_\\(.\\)" (lambda (x) (upcase (substring x 1))) symbol)))
        (delete-region start end)
        (goto-char start)
        (insert new-symbol)))))


(global-set-key (kbd "C-c s c") 'snake-to-camel)



(use-package nerd-icons  :ensure t)

;; (use-package typewriter)


(use-package hima-theme

  :ensure t)


;; (use-package codespaces

;;   :config (codespaces-setup)
;;   :bind ("C-c S" . #'codespaces-connect))



;; (use-package fira-code-mode
;;   :ensure t
;;   :custom (fira-code-mode-disabled-ligatures '("[]" "x"))  ; ligatures you don't want
;;   :config
;;   (global-fira-code-mode)
;;   :hook (prog-mode . fira-code-mode))

(use-package doom-themes

  :ensure t
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled

  ;; Enable custom neotree theme (all-the-icons must be installed!)
  (doom-themes-neotree-config)
  ;; or for treemacs users
  (setq doom-themes-treemacs-theme "doom-atom") ; use "doom-colors" for less minimal icon theme
  (doom-themes-treemacs-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

;; (when (window-system)
;;   (set-frame-font "FiraCode Nerd Font Mono"))
(let ((alist '((33 . ".\\(?:\\(?:==\\|!!\\)\\|[!=]\\)")
               (35 . ".\\(?:###\\|##\\|_(\\|[#(?[_{]\\)")
               (36 . ".\\(?:>\\)")
               (37 . ".\\(?:\\(?:%%\\)\\|%\\)")
               (38 . ".\\(?:\\(?:&&\\)\\|&\\)")
               (42 . ".\\(?:\\(?:\\*\\*/\\)\\|\\(?:\\*[*/]\\)\\|[*/>]\\)")
               (43 . ".\\(?:\\(?:\\+\\+\\)\\|[+>]\\)")
               (45 . ".\\(?:\\(?:-[>-]\\|<<\\|>>\\)\\|[<>}~-]\\)")
               (46 . ".\\(?:\\(?:\\.[.<]\\)\\|[.=-]\\)")
               (47 . ".\\(?:\\(?:\\*\\*\\|//\\|==\\)\\|[*/=>]\\)")
               (48 . ".\\(?:x[a-zA-Z]\\)")
               (58 . ".\\(?:::\\|[:=]\\)")
               (59 . ".\\(?:;;\\|;\\)")
               (60 . ".\\(?:\\(?:!--\\)\\|\\(?:~~\\|->\\|\\$>\\|\\*>\\|\\+>\\|--\\|<[<=-]\\|=[<=>]\\||>\\)\\|[*$+~/<=>|-]\\)")
               (61 . ".\\(?:\\(?:/=\\|:=\\|<<\\|=[=>]\\|>>\\)\\|[<=>~]\\)")
               (62 . ".\\(?:\\(?:=>\\|>[=>-]\\)\\|[=>-]\\)")
               (63 . ".\\(?:\\(\\?\\?\\)\\|[:=?]\\)")
               (91 . ".\\(?:]\\)")
               (92 . ".\\(?:\\(?:\\\\\\\\\\)\\|\\\\\\)")
               (94 . ".\\(?:=\\)")
               (119 . ".\\(?:ww\\)")
               (123 . ".\\(?:-\\)")
               (124 . ".\\(?:\\(?:|[=|]\\)\\|[=>|]\\)")
               (126 . ".\\(?:~>\\|~~\\|[>=@~-]\\)")
               )
             ))
  (dolist (char-regexp alist)
    (set-char-table-range composition-function-table (car char-regexp)
                          `([,(cdr char-regexp) 0 font-shape-gstring]))))

(use-package tao-theme

  :ensure t)


(use-package focus

  :ensure t)


(use-package geiser

  :ensure t)

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


(use-package minimap

  :ensure t)




(use-package eyebrowse :ensure t
  :config
  (eyebrowse-mode))

(setq user-mail-address "ayush@wasmer.io"
      user-full-name "Ayush Jha")

(setq gnus-select-method
      '(nnimap "gmail"
	       (nnimap-address "imap.gmail.com")  ; it could also be imap.googlemail.com if that's your server.
	       (nnimap-server-port "imaps")
	       (nnimap-stream ssl)))
(setq smtpmail-smtp-server "smtp.gmail.com"
      smtpmail-smtp-service 587
      gnus-ignored-newsgroups "^to\\.\\|^[0-9. ]+\\( \\|$\\)\\|^[\"]\"[#'()]")



(defun insert-diff-into-commit-buffer ()
  "Insert the diff of staged changes into the commit buffer."
  (interactive)
  (let* ((git-dir (magit-git-dir))
         (diff (magit-git-string "diff" "--staged"))
         (buffer (or (get-buffer "*magit: COMMIT_EDITMSG*")
                     (current-buffer))))  ; just to be safe
    (with-current-buffer buffer
      (goto-char (point-max))
      (insert "\n\n" diff))))



(use-package kubernetes
  :ensure t
  :config (fset 'k8s 'kubernetes-overview))
