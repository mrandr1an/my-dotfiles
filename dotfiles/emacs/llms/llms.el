(use-package gptel
  :ensure t
  :config  
(setq
 gptel-model 'mistral:latest
 gptel-backend (gptel-make-ollama "Ollama"
                 :host "localhost:11434"
                 :stream t
                 :models '(dolphin-mistral)))
)


(provide 'llms)
