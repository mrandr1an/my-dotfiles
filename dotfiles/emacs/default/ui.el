;;; Package -- Summary
;;; Commentary:
;;; Code:

;;; Disable ugly UI
(defun default/ui-enable ()
  "Enable sensible defaults for EMACS UI configuration."
 (tool-bar-mode -1)
 (menu-bar-mode -1)
 (scroll-bar-mode -1)
 ;;Vim-like scrolling
 (setq scroll-step 1)
 (setq scroll-margin 1)
 (setq scroll-conservatively 9999)
)

(provide 'ui)
;;; ui.el ends here
