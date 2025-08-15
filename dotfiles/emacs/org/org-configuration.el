(require 'org-aesthetics)

(use-package org
  :ensure nil
  :custom
  (setq org-pretty-entities t)
  (custom-set-faces
   '(org-level-1 ((t (:height 1.4 :weight bold :foreground "#ff6c6b"))))
   '(org-level-2 ((t (:height 1.2 :weight semi-bold :foreground "#98be65"))))
   '(org-level-3 ((t (:height 1.1 :foreground "#da8548")))))
  :hook
  (org-mode . my/org-font-lock)
  (org-mode . prettify-symbols-mode)
)

(use-package org-download
  :ensure t
)


(use-package org-transclusion
  :ensure t
  :after org
  :init
  :general
  (:prefix "C-c n"
    "q" 'org-transclusion-add
  )
)

(provide 'org-configuration)
