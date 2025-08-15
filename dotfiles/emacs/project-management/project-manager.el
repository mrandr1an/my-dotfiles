;;; package --- Summary
;;; Commentary:

;;; Code:

(use-package projectile 
  :ensure t
  :config
  (projectile-mode +1)
  (projectile-cleanup-known-projects)
  :general
  (
   :prefix "C-c p"
   "f"  'projectile-find-file
   "s"  'projectile-switch-project
   "r"  'projectile-find-references
   "c"  'projectile-compile-project
   "t"  'projectile-test-project
   "p"  'projectile-run-command-in-root
   "v"  'projectile-version
  )
)

(provide 'project-manager)
;;project-manager.el
