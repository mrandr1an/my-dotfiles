(use-package citar
  :ensure t
  :custom
  (citar-bibliography '("~/Documents/Bibliography/references.bib"))
  (citar-library-paths '("~/"))
  (citar-file-parser-functions
  '(citar-file--parser-default
    citar-file--parser-triplet
    )
  )
  :config

  (defvar citar-indicator-notes-icons
  (citar-indicator-create
   :symbol (nerd-icons-mdicon
            "nf-md-notebook"
            :face 'nerd-icons-blue
            :v-adjust -0.3)
   :function #'citar-has-notes
   :padding "  "
   :tag "has:notes"))

    (defvar citar-indicator-links-icons
    (citar-indicator-create
    :symbol (nerd-icons-octicon
		"nf-oct-link"
		:face 'nerd-icons-orange
		:v-adjust -0.1)
    :function #'citar-has-links
    :padding "  "
    :tag "has:links"))

    (defvar citar-indicator-files-icons
    (citar-indicator-create
    :symbol (nerd-icons-faicon
		"nf-fa-file"
		:face 'nerd-icons-green
		:v-adjust -0.1)
    :function #'citar-has-files
    :padding "  "
    :tag "has:files"))

    (setq citar-indicators
    (list citar-indicator-files-icons
	    citar-indicator-notes-icons
	    citar-indicator-links-icons))
)

(use-package citar-embark
  :after citar embark
  :ensure t
  :config (citar-embark-mode)
  )

(use-package citar-org-roam
  :ensure t
  :after (citar org-roam)
  :config (citar-org-roam-mode))

(provide 'bib-notes)
