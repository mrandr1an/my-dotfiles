(use-package ebib
  :ensure t
  :config
  (setq ebib-default-directory "~/Documents/Bibliography/")
  (setq ebib-bib-search-dirs "~/Documents/Bibligraphy")
  (setq ebib-bibtex-dialect  (car (cdr bibtex-dialect-list)) )
)

(use-package biblio
  :ensure t
)

(provide 'bib-manager)
