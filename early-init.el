;;; early-init.el --- Emacs early initialization for Crafted Emacs (optional) -*- lexical-binding: t; -*-
;;; Commentary:
;;
;;; Code:

;; Managed through nix
;; Configures `package.el'
;;(load "~/projects/code/crafted-emacs/modules/crafted-early-init-config")

(scroll-bar-mode -1)        ; Disable visible scrollbar
(tool-bar-mode -1)          ; Disable the toolbar
(tooltip-mode -1)           ; Disable tooltips
(unless window-system
  (menu-bar-mode -1))       ; Disable menu bar if in terminal

(provide 'early-init)

;;; early-init.el ends here
