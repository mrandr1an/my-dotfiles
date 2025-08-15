(use-package avy
  :ensure t
  :general
  (
   :keymaps 'normal 
   :prefix "<SPC>"
   "c" 'evil-avy-goto-char
   "w" 'evil-avy-goto-word-0
   "W" 'evil-avy-goto-word-1
   "l" 'evil-avy-goto-line
   "C" 'evil-avy-goto-char-2
   "v" 'evil-avy-goto-subword-0
   "V" 'evil-avy-goto-subword-1
   "z" 'avy-move-line
   "Z" 'avy-move-region
   )
)

(provide 'avy-motions)
