(defun corfu-move-to-minibuffer ()
  (interactive)
  (pcase completion-in-region--data
    (`(,beg ,end ,table ,pred ,extras)
     (let ((completion-extra-properties extras)
           completion-cycle-threshold completion-cycling)
       (consult-completion-in-region beg end table pred)))))

(use-package corfu
  :ensure t
  :general
  (
   :keymaps 'corfu-map
	    "C-k" 'corfu-previous
	    "C-j" 'corfu-next
	    "C-d" 'corfu-info-documentation
	    "C-a" 'corfu-info-location
	    "C-h" 'corfu-quit
	    "C-l" 'corfu-insert
	    "C-m" 'corfu-move-to-minibuffer
  )
  ("C-l" 'completion-at-point)
  :custom
  (corfu-cycle t)
  (corfu-history-mode)
  (corfu-quit-at-boundary 'seperator)
  (add-to-list 'corfu-continue-commands #'corfu-move-to-minibuffer)
  :hook
  (org-mode . corfu-mode)
)

(use-package dabbrev
  :ensure nil
  :bind (("C-M-/" . dabbrev-expand))
  :config
  (add-to-list 'dabbrev-ignored-buffer-regexps "\\` ")
  (add-to-list 'dabbrev-ignored-buffer-modes 'doc-view-mode)
  (add-to-list 'dabbrev-ignored-buffer-modes 'pdf-view-mode)
  (add-to-list 'dabbrev-ignored-buffer-modes 'tags-table-mode)
)

(use-package cape
  :ensure t
  :init
  (add-hook 'completion-at-point-functions #'cape-dabbrev)
  (add-hook 'completion-at-point-functions #'cape-file)
  (add-hook 'completion-at-point-functions #'cape-elisp-block)
  (add-hook 'completion-at-point-functions #'cape-history)
  (add-hook 'completion-at-point-functions #'cape-abbrev)
  (add-hook 'completion-at-point-functions #'cape-dict)
  (add-hook 'completion-at-point-functions #'cape-elisp-block)
  (add-hook 'completion-at-point-functions #'cape-keyword)
  (add-hook 'completion-at-point-functions #'cape-tex)
)

(use-package kind-icon
  :ensure t
  :after corfu
  :config
  (add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter))

(provide 'region-autocomplete)
