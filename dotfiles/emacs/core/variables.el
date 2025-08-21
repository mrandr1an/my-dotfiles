;;; Package --- Summary
;;; Commentary:
;;;  Global Variables and Groups Library for my EMACS configuration
;;;   - Everything is prepended with core/
;;;   - Macros are appended with '!'
;;; Code:

(defgroup core/emacs nil
  "Group for every configuration of this EMACS set-up."
  :group 'emacs
  :prefix "core/"
)

(defcustom core/features nil
  "List of features available in this configuration."
  :type '(repeat symbol)
)

(provide 'variables)
;;; variables.el ends here
