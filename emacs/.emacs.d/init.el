;;; Personal configuration -*- lexical-binding: t -*-

;; Save the contents of this file under ~/.emacs.d/init.el
;; Do not forget to use Emacs' built-in help system:
;; Use C-h C-h to get an overview of all help commands.  All you
;; need to know about Emacs (what commands exist, what functions do,
;; what variables specify), the help system can provide.

(setq gc-cons-threshold (* 256 1024 1024))
(setq read-process-output-max (* 1024 1024))

(setq warning-minimum-level :error)

(custom-set-variables
 '(auto-save-file-name-transforms '(("." "~/.emacs.d/autosaves/\1" t)))
 '(backup-directory-alist '(("." . "~/.emacs.d/backups"))))
(make-directory "~/.emacs.d/autosaves" t)
(make-directory "~/.emacs.d/backups" t)

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        (or (bound-and-true-p straight-base-dir)
            user-emacs-directory)))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(setq package-enable-at-startup nil)

(straight-use-package 'use-package)


(use-package modus-themes
  :straight t)

(use-package ef-themes
  :straight t)

(load-theme 'ef-dream t)

(use-package doom-modeline
  :straight t
  :init (doom-modeline-mode t))

(use-package all-the-icons
  :straight t)

(add-to-list 'default-frame-alist '(font . "Iosvmata-12"))

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(use-package yasnippet
  :straight t
  )

(use-package flycheck
  :straight t
  ;;  :custom (flycheck-check-syntax-automatically '(save-mode-enable))
  )


(use-package lsp-mode
  :init
  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  (setq lsp-keymap-prefix "C-c l")
  :hook ((prog-mode . (lambda ()
			(unless (derived-mode-p '(emacs-lisp-mode racket-mode gerbil-mode scheme-mode))
			  (lsp-deferred))))
	 ;;(prog-mode . lsp-deferred)
	 (lsp-mode . lsp-lens-mode)
         (lsp-mode . (flymake-mode-off))))

(use-package lsp-ui
  :straight t
  :init
  (setq lsp-ui-doc-enable t
	lsp-ui-sideline-diagnostic-max-lines 7
	lsp-ui-sideline-diagnostic-max-line-length 40
	lsp-lens-enable nil
	lsp-ui-doc-show-with-cursor t
	lsp-ui-doc-delay 0.2))


(use-package swiper
  :straight t
  :bind
  ("\C-s" . swiper))


(use-package windmove
  :straight t
  :bind
  ("C-c <right>" . windmove-right)
  ("C-c <left>" . windmove-left)
  ("C-c <up>" . windmove-up)
  ("C-c <down>" . windmove-down))


(use-package perspective
  :straight t
  :bind (("C-x k" . persp-kill-buffer*))
  :init
  (persp-mode)
  :custom (persp-suppress-no-prefix-key-warning t))


(use-package move-text
  :straight t
  :bind
  ("M-<up>" . move-text-up)
  ("M-<down>" . move-text-down))


(use-package corfu
  :straight t
  :custom ((corfu-auto t)
	   (corfu-auto-defer 0.25)
	   (corfu-min-width 15)
	   (corfu-max-width 70)
	   (corfu-auto-prefix 1)
	   (corfu-popupinfo-defer corfu-auto-defer))
  :hook ((prog-mode . (lambda ()
			(corfu-mode)))
	 (sql-mode . (lambda ()
		       (corfu-mode -1)))
	 (corfu-mode . corfu-popupinfo-mode)
	 (eshell-mode . corfu-mode)))

(add-hook 'prog-mode-hook #'corfu-mode)

(setq corfu-auto t)

(use-package typescript-mode
  :after lsp-mode
  :straight t
  :mode (("\\.ts$" . typescript-mode)
         ("\\.tsx$" . tsx-ts-mode))
  :hook (typescript-mode . lsp-deferred))

(use-package javascript-mode
  :after lsp-mode
  :straight t
  :hook (javascript-mode . lsp-deferred))

(use-package lsp-tailwindcss
  :straight t
  :defer t
  :config
  (add-to-list 'lsp-language-id-configuration '(".*\\.erb$" . "html")) ;; Associate ERB files with HTML.
  :init
  (setq lsp-tailwindcss-add-on-mode t))


(use-package markdown-mode
  :after lsp-mode
  :straight t
  :hook (markdown-mode . lsp-deferred))


(use-package json-mode
  :after lsp-mode
  :straight t
  :hook (json-mode . lsp-deferred))


(add-hook 'prog-mode-hook #'display-line-numbers-mode)


(electric-pair-mode t)

(add-hook 'prog-mode-hook #'flymake-mode)


(with-eval-after-load 'flymake
  (define-key flymake-mode-map (kbd "M-n") #'flymake-goto-next-error)
  (define-key flymake-mode-map (kbd "M-p") #'flymake-goto-prev-error))


(use-package magit
  :straight t
  :bind
  ("C-x g" . magit-status)
  :config
  (use-package diff-hl
    :straight t))


(use-package helm
  :straight t
  :init
  (helm-mode t)
  (set-face-attribute 'helm-selection nil
		      :background (color-lighten-name (face-attribute 'default :foreground) 50)
		      :foreground (color-darken-name (face-attribute 'default :background) 100))
  :bind
  ("M-x" . helm-M-x)
  ("M-i" . helm-imenu)
  ("C-x b" . helm-buffers-list))
(use-package helm-lsp
  :straight t)
(define-key lsp-mode-map [remap xref-find-apropos] #'helm-lsp-workspace-symbol)


(use-package projectile
  :straight t
  :init
  (setq projectile-project-search-path '("~/desk/"))
  (projectile-mode t)
  :bind-keymap
  ("C-c p" . projectile-command-map))


(use-package all-the-icons
  :straight t)


(use-package dashboard
  :after projectile
  :straight t
  :after all-the-icons
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-center-content t)
  (setq dashboard-startup-banner "~/.emacs.d/sources/savannah.png")
  (setq dashboard-banner-logo-title "Welcome to Emacs!")
  (setq dashboard-items '((recents . 5)
			  (bookmarks . 5)
			  (projects . 5)))
  (setq dashboard-center-content t)
  (setq dashboard-footer-messages '("I have no idea where this will lead us, but I have a definite feeling it will be a place both wonderful and strange")))


(use-package transpose-frame
  :straight t)


(use-package org-drill
  :straight t)


(use-package sly
  :straight t
  :hook ((sly-mode . corfu-mode)
	 (sly-mode . smartparens-mode))
  :init
  ;; (setq sly-lisp-implementations
  ;; '((sbcl ("/etc/profiles/per-user/mmagueta/bin/sbcl"))
  ;; (ecl ("/etc/profiles/per-user/mmagueta/bin/ecl"))))
  (defun sly-eval-last-expression-eros ()
    (interactive)
    (cl-destructuring-bind (output value)
	(sly-eval `(swank:eval-and-grab-output ,(sly-last-expression)))
      (eros--make-result-overlay (concat output value)
	:where (point)
	:duration eros-eval-result-duration)))
  :bind (:map sly-mode-map
	      ("C-x C-e" . sly-eval-last-expression-eros)))


(use-package geiser-mit
  :straight t)

;;(use-package geiser-racket
;;  :straight t
;;  :after geiser-mit)

;;(use-package racket-mode
;;  :straight t
;;  :after geiser-racket
;;  :hook ((racket-mode . lsp-deferred)))


;; (use-package gerbil-mode
;;   :straight (:host github
;; 		   :repo "mighty-gerbils/gerbil"
;; 		   :files ("etc/gerbil-mode.el")
;; 		   :branch "master")
;;   :when (file-directory-p *gerbil-path*)
;;   :preface
;;   (defvar *gerbil-path*
;;     (shell-command-to-string "gxi -e '(display (path-expand \"~~\"))'\
;;       -e '(flush-output-port)'"))
;;   (defun gerbil-setup-buffers ()
;;     "Change current buffer mode to gerbil-mode and start a REPL"
;;     (interactive)
;;     (gerbil-mode)
;;     (split-window-right)
;;     (shrink-window-horizontally 2)
;;     (let ((buf (buffer-name)))
;;       (other-window 1)
;;       (run-scheme "gxi")
;;       (switch-to-buffer-other-window "*scheme*" nil)
;;       (switch-to-buffer buf)))
;;   (defun clear-comint-buffer ()
;;     (interactive)
;;     (with-current-buffer "*scheme*"
;;       (let ((comint-buffer-maximum-size 0))
;;         (comint-truncate-buffer))))
;;   :mode (("\\.ss\\'"  . gerbil-mode)
;;          ("\\.pkg\\'" . gerbil-mode))
;;   :bind (:map comint-mode-map
;; 	      (("C-S-n" . comint-next-input)
;; 	       ("C-S-p" . comint-previous-input)
;; 	       ("C-S-l" . clear-comint-buffer))
;; 	      :map gerbil-mode-map
;; 	      (("C-S-l" . clear-comint-buffer)))
;;   :init
;;   (autoload 'gerbil-mode
;;     (expand-file-name "share/emacs/site-lisp/gerbil-mode.el" *gerbil-path*)
;;     "Gerbil editing mode." t)
;;   (global-set-key (kbd "C-c C-g") 'gerbil-setup-buffers)
;;   :hook
;;   (inferior-scheme-mode . gambit-inferior-mode)
;;   :after (scheme-mode)
;;   :config
;;   ;;  (when (fboundp 'derived-mode-add-parents)
;;   ;;    (derived-mode-add-parents 'gerbil-mode '(prog-mode)))
;;   (require 'gambit
;;            (expand-file-name "share/emacs/site-lisp/gambit.el" *gerbil-path*))
;;   (setf scheme-program-name (expand-file-name "bin/gxi" *gerbil-path*))
;;   (let ((tags (locate-dominating-file default-directory "TAGS")))
;;     (when tags (visit-tags-table tags)))
;;   (let ((tags (expand-file-name "src/TAGS" *gerbil-path*)))
;;     (when (file-exists-p tags) (visit-tags-table tags))))


(use-package geiser-guile
  :straight t
  :after geiser-mit)
(setq geiser-guile-binary "guile")
(setq geiser-scheme-implementation 'guile)
(setq geiser-active-implementations '(guile))

(setq scheme-program-name "guile")


(use-package cider
  :straight t
  :hook (cider-mode . corfu-mode))

(use-package clojure-mode
  :straight t
  :after (cider lsp-mode)
  :hook ((clojure-mode . lsp-deferred)))

(use-package rainbow-delimiters
  :straight t
  :hook
  (lisp-mode . rainbow-delimiters-mode)
  (clojure-mode . rainbow-delimiters-mode)
  ;;(racket-mode . rainbow-delimiters-mode)
  (emacs-lisp-mode . rainbow-delimiters-mode)
;;  (gerbil-mode . rainbow-delimiters-mode)
  (scheme-mode . rainbow-delimiters-mode))

(use-package smartparens
  :straight t
  :hook ((lisp-mode . smartparens-mode)
	 (emacs-lisp-mode . smartparens-mode)
	 (clojure-mode . smartparens-mode)
	 (cider-mode . smartparens-mode)
;;	 (racket-mode . smartparens-mode)
;;	 (gerbil-mode . smartparens-mode)
	 (scheme-mode . smartparens-mode))
  :bind (:map smartparens-mode-map
	      ("C-M-<right>" . 'sp-forward-sexp)
	      ("C-M-<left>" . 'sp-backward-sexp)
	      ("C-M-<down>" . 'sp-down-sexp)
	      ("C-M-<up>" . 'sp-up-sexp)
	      ("C-k" . 'sp-kill-sexp)
	      ("M-r" . 'sp-copy-sexp)
	      ("C-M-s" . 'sp-forward-slurp-sexp)
	      ("C-S-s" . 'sp-backward-slurp-sexp)
	      ("C-M-b" . 'sp-forward-barf-sexp)
	      ("C-S-b" . 'sp-backward-barf-sexp)))


(use-package lsp-java
  :straight t
  :after lsp-mode
  :hook (java-mode . lsp-deferred))


(use-package protobuf-mode
  :straight t)


(use-package sqlformat
  :straight t
  :ensure t
  :custom
  (sqlformat-command 'pgformatter)
  (sqlformat-args '("-s2" "-g")))


(use-package eros
  :straight t
  :hook (emacs-lisp-mode . eros-mode))


;;(use-package peg
;;  :straight t)

(use-package pgmacs
  :straight (:host github :repo "MMagueta/pgmacs" :branch "add-script-support" :files ("dist" "*.el"))
  :after peg)


(use-package direnv
  :straight t)

(use-package projectile-direnv
  :straight t)


(use-package which-key
  :straight t
  :config
  (which-key-mode))
(setq which-key-idle-delay 0.2)


(setq-default major-mode
	      (lambda () ; guess major mode from file name
                (unless buffer-file-name
                  (let ((buffer-file-name (buffer-name)))
                    (set-auto-mode)))))
(setq confirm-kill-emacs #'yes-or-no-p)
(setq window-resize-pixelwise t)
(setq frame-resize-pixelwise t)
(save-place-mode t)
(savehist-mode t)
(recentf-mode t)
(defalias 'yes-or-no #'y-or-n-p)

(setq backup-directory-alist `(("." . "~/.emacs.d/backup")))

;; Disable beep
(setq visible-bell t)
(setq ring-bell-function 'ignore)

;; Store automatic customisation options elsewhere
(setq custom-file (locate-user-emacs-file "custom.el"))
(when (file-exists-p custom-file)
  (load custom-file))
