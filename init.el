;;; init.el -*- lexical-binding: t; -*-

;;; Initial phase.

;; Load the custom file if it exists.  Among other settings, this will
;; have the list `package-selected-packages', so we need to load that
;; before adding more packages.  The value of the `custom-file'
;; variable must be set appropriately, by default the value is nil.
;; This can be done here, or in the early-init.el file.
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (and custom-file
           (file-exists-p custom-file))
  (load custom-file nil 'nomessage))

;; Adds crafted-emacs modules to the `load-path', sets up a module
;; writing template, sets the `crafted-emacs-home' variable.
(load "~/projects/code/crafted-emacs/modules/crafted-init-config")

(custom-set-faces
 '(default ((t :family "Iosevka Nerd Font Mono" :weight regular :height 200)))
 '(bold ((t :weight semibold))))


(setq use-short-answers t
      make-backup-files nil
      create-lockfiles nil)
      
(column-number-mode 1)
(blink-cursor-mode 0)
(global-hl-line-mode 1)

(use-package emacs
  :init
  ;; Add all your customizations prior to loading the themes
  (setq modus-themes-disable-other-themes t
      modus-themes-hl-line '(accented)
      modus-themes-region '(bg-only)
      modus-themes-bold-constructs t
      modus-themes-italic-constructs t
      modus-themes-tabs-accented t
      modus-themes-fringes nil
      modus-themes-paren-match '(bold intense)
      modus-themes-mode-line '(borderless moody)
      modus-themes-subtle-line-numbers t
      modus-themes-scale-headings t)
        
  (setq modus-themes-headings
       '((1 . (rainbow overline 1.4))
         (2 . (rainbow 1.3))
         (3 . (rainbow bold 1.2))
         (t . (semilight 1.1))))
          
  :config
  (load-theme 'modus-operandi))



(moody-replace-mode-line-buffer-identification)
(moody-replace-vc-mode)
(moody-replace-eldoc-minibuffer-message-function)
(setq x-underline-at-descent-line t
      x-use-underline-position-properties nil)

(global-set-key (kbd "C-h D") #'eldoc-box-help-at-point)
(defun my-eglot-organize-imports () (interactive)
	 (eglot-code-actions nil nil "source.organizeImports" t))
(add-hook 'before-save-hook 'my-eglot-organize-imports nil t)
(add-hook 'before-save-hook 'eglot-format-buffer)
(add-hook 'go-ts-mode-hook 'eglot-ensure)
(add-hook 'rust-ts-mode-hook 'eglot-ensure)
(with-eval-after-load "prog-mode"
  (keymap-set prog-mode-map "C-c e n" #'flymake-goto-next-error)
  (keymap-set prog-mode-map "C-c e p" #'flymake-goto-prev-error))

;;; Packages phase

;;; Packages provided by nix in separate configuration

;;; Configuration phase

;; Some example modules to configure Emacs. Don't blindly copy these,
;; they are here for example purposes.  Find the modules which work
;; for you and add them here.
(require 'crafted-defaults-config)
(require 'crafted-startup-config)
(require 'crafted-completion-config)
(require 'crafted-evil-config)
(require 'crafted-ui-config)
(require 'crafted-osx-config)
(require 'crafted-workspaces-config)
(require 'crafted-ide-config)
(require 'crafted-org-config)
(crafted-ide-configure-tree-sitter '(protobuf)) ; don't set up protobuf grammar

(envrc-global-mode)
(which-key-mode)
(use-package which-key
  :init (which-key-mode)
  :config
  (setq which-key-idle-delay 0.3))

;; TEMP COPY OF  https://raw.githubusercontent.com/protesilaos/denote/main/denote-journal-extras.el which is not available in 2.0.0
;; (load-file "~/projects/code/emacs-home-dir/denote-journal-extras.el")
;; (setq
;;  eldoc-echo-area-use-multiline-p nil
;;  denote-directory "~/org/denote/"
;;  denote-journal-extras-directory "~/org/denote/journal/")

;;; Optional configuration

;; Profile emacs startup
(defun crafted-startup-example/display-startup-time ()
  "Display the startup time after Emacs is fully initialized."
  (message "Crafted Emacs loaded in %s."
           (emacs-init-time)))
(add-hook 'emacs-startup-hook #'crafted-startup-example/display-startup-time)

;; Set default coding system (especially for Windows)
(set-default-coding-systems 'utf-8)
