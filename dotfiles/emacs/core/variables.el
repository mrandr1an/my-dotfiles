;;; Package --- Summary
;;; Commentary:
;;; Code:

(defgroup my-emacs/variables nil
  "Customization group for my-emacs variables."
  :group 'emacs
)

;;; Directory variables

(defcustom my-emacs/projects-dir "~/Projects"
  "Directory where projects are supposed to be."
  :type 'string
  :group 'my-emacs/variables
)

(defcustom my-emacs/agenda-dir "~/Documents/Agenda/"
  "Directory where agenda is supposed to be."
  :type 'string
  :group 'my-emacs/variables
)

(defcustom my-emacs/bibliography-dir "~/Documents/Bibliography/"
  "Directory where bibliography is supposed to be."
  :type 'string
  :group 'my-emacs/variables
)

(defcustom my-emacs/notes-dir "~/Documents/Notes/"
  "Directory where notes are supposed to be."
  :type 'string
  :group 'my-emacs/variables
)


(defcustom my-emacs/roam-notes-dir (concat my-emacs/notes-dir "Roam/")
  "Directory where roam notes are supposed to be."
  :type 'string
  :group 'my-emacs/variables
)

(defcustom my-emacs/roam-templates-dir (concat my-emacs/notes-dir "Roam/RoamTemplates/")
  "Directory where roam templates are supposed to be."
  :type 'string
  :group 'my-emacs/variables
)

(defcustom my-emacs/bib-references (concat my-emacs/bibliography-dir "references.org")
  "Directory where roam templates are supposed to be."
  :type 'string
  :group 'my-emacs/variables
)

(defcustom my-emacs/bib-pdfs-dir (concat my-emacs/bibliography-dir "pdfs")
  "Directory where roam templates are supposed to be."
  :type 'string
  :group 'my-emacs/variables
)

(defcustom my-emacs/journal-dir "~/Documents/Journal/"
  "Directory where notes are supposed to be."
  :type 'string
  :group 'my-emacs/variables
)

;;; Configuration Variables

(defcustom my-emacs/enable-evil t
  "Enable evil mode on startup if non-nil."
  :type 'boolean
  :group 'my-emacs/variables
)

(provide 'variables)
;;; variables.el ends here

