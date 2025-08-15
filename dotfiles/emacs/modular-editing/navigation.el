(use-package consult
  :ensure t
  :general
  ;;Buffer Navigation
  (:prefix "C-c"
	   "b"  'consult-buffer
	   "w" 'consult-buffer-other-window
	   "B" 'consult-bookmark
	   "F" 'consult-buffer-other-frame
	   "p" 'consult-project-buffer
	   "f" 'consult-find
	   "g" 'consult-grep
	   "r" 'consult-ripgrep
	   "t" 'consult-git-grep
	   "l" 'consult-line
	   "x" 'consult-mode-command
  )
  ;;Info Related
)

(use-package embark-consult
  :ensure t
  :hook
  (embark-collect-mode . consult-preview-at-point-mode)
)

(use-package embark
  :ensure t
  :general
  (
   "C-." 'embark-act
   "C-h B" 'embark-bindings
  )
)

(provide 'navigation)
