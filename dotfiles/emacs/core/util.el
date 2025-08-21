;;; Package --- Summary
;;; Commentary:
;;;  Utils Library for my EMACS configuration
;;;   - Everything is prepended with core/
;;;   - Macros are appended with '!'
;;; Code:

(require 'variables)

(defmacro core/load! (dir)
  "Add DIR (relative to USER-EMACS-DIRECTORY) to LOAD-PATH."
  `(add-to-list 'load-path (expand-file-name ,dir user-emacs-directory)))

(defun core/try-import (feature fail-fn)
  "Try to REQUIRE the FEATURE and return true.
If it fails call FAIL-FN and return nil."
  (condition-case err
      (progn (require feature) t)
      (error (funcall fail-fn 'feature err) nil)
      ))

(defun core/enable-feature (feat-dir feat-name)
  "Add FEAT-DIR in 'load-path' and require FEAT-NAME."
  (core/load! feat-dir)
  (core/try-import feat-name ())
)

(provide 'util)
;;; util.el ends here
