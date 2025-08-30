;;; package --- Summary
;;; Commentary:

;;; Code:

;;; Ensure `user-emacs-directory` is set correctly
;; (setq user-emacs-directory (file-name-directory load-file-name))

(add-to-list 'load-path (expand-file-name "core" user-emacs-directory))

(require 'util)
; Now util functions are available
(require 'variables)
; Now variables functions are available

(core/load! "default")

(require 'ui)
; Now ui functions are available

(default/ui-enable)

;; Load settings that dont require packages
(require 'settings)

;;; This should be disabled manually for bootstraping elpaca
(setq package-enable-at-startup nil)

(provide 'early-init)
;;; early-init.el ends here
