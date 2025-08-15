(require 'variables)

(use-package org-roam
  :ensure t
  :init
  (setq org-roam-v2-ack t)
  (org-roam-db-sync)
  :custom
  (org-roam-directory my-emacs/roam-notes-dir)
  (org-roam-capture-templates
   '(
     ("b" "Book Notes" plain
      (file "~/Documents/Notes/RoamTemplates/BookNoteTemplate.org")
      :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "TITLE: ${title}\n#+filetags: Book")
      :unnarrowed t
      )
      ("t" "Tutorial Notes, Quick setups etc" plain
      (file "~/Documents/Notes/RoamTemplates/TutorialTemplate.org")
      :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "TITLE: ${title}\n#+filetags: Tutorial")
      :unnarrowed t
      )
     ("g" "General Notes" plain
      (file "~/Documents/Notes/RoamTemplates/GeneralTemplate.org")
      :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+filetags: :note:${tag}:")
      :unnarrowed t
      )
     ("p" "Project ideas" plain
      (file "~/Documents/Notes/RoamTemplates/GeneralTemplate.org")
      :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+filetags: :project:${tag}:")
      :unnarrowed t
      )
    )
  )
  :general
  (:prefix "C-c n"
	   "i" 'org-roam-node-insert
	   "f" 'org-roam-node-find
	   "t" 'org-roam-buffer-toggle
	   "a" 'org-roam-tag-add
	   "s" 'org-roam-tag-remove
	   "n" 'org-roam-capture
	   "d" 'org-roam-dailies-goto-date
	   "D" 'org-roam-dailies-goto-tomorrow
	   "m" 'org-roam-dailies-goto-today
	   "y" 'org-roam-ref-add
	   "u" 'org-roam-ref-remove
  )
)

(use-package org-ql
  :ensure t
  :after org
)

(use-package org-roam-ql
  :ensure t
  :after org
  :general
  (:prefix "C-c s"
    ("t" . 'org-roam-ql-insert-node-title)
  )
)

(use-package org-roam-ql-ql
  :ensure t
  :after (org-ql org-roam-ql)
  :config
  (org-roam-ql-ql-init)
)

(provide 'roam-notes)
