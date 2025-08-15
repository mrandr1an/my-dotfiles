;;; package --- Summary
;;; Commentary:

;;; Code:

(use-package transient
  :ensure t
)

(use-package magit 
  :ensure t
  :general
  (:prefix "C-c m"
    "g" 'magit-status
    "d" 'magit-dispatch
    "f" 'magit-file-dispatch
    "i" 'magit-init
    "c" 'magit-clone 
  )
)

(provide 'versioning)
;;project-manager.el
