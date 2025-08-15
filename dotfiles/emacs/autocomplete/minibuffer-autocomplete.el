(use-package vertico
  :ensure t
  :custom
  (vertico-cycle t)
  :init
  (vertico-mode) 
  :general
  (
   :keymaps 'vertico-map
	    "C-k" 'vertico-previous
	    "C-j" 'vertico-next
  )
)

(use-package marginalia
  :ensure t
  :init
  (marginalia-mode)
)

(provide 'minibuffer-autocomplete)
