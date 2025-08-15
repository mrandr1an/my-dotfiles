(use-package lsp-bridge
  :ensure '(lsp-bridge :type git :host github :repo "manateelazycat/lsp-bridge"
  		:files (:defaults "*.el" "*.py" "acm" "core" "langserver" "multiserver" "resources")
  		:build (:not compile))
  :general
  (
    :keymaps 'acm-mode-map
    "C-j" 'acm-select-next
    "C-k" 'acm-select-prev
    "M-l" 'acm-doc-toggle
    "M-k" 'acm-doc-scroll-up
    "M-j" 'acm-doc-scroll-down
    "C-l" 'acm-complete
    "C-h" 'acm-hide
    )
  (general-define-key
   :states 'normal
   :predicate '(lsp-bridge-mode)
   :prefix "C-z"
   "g" 'lsp-bridge-find-def
   "G" 'lsp-bridge-find-def-other-window
   "i" 'lsp-bridge-find-impl
   "I" 'lsp-bridge-find-impl-other-window
   "H" 'lsp-bridge-show-documentation
   "l" 'lsp-bridge-diagnostic-list
  )
)

(provide 'programming-lsp)
