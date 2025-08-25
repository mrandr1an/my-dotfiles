(setq org-latex-compiler "lualatex")
(setq org-latex-pdf-process '("lualatex -interaction=nonstopmode -halt-on-error -output-directory=%o %f"))

(setq org-preview-latex-process-alist
      '((imagemagick
         :programs ("lualatex" "convert")          ;; executables required
         :description "lualatex -> convert (png)"
         :message "Install lualatex and ImageMagick (plus ghostscript)."
         :image-input-type "pdf"                   ;; we get a PDF from lualatex
         :image-output-type "png"                  ;; produce PNGs
         :image-size-adjust (1.0 . 1.0)            ;; no scaling
         :latex-compiler
           ("lualatex -interaction=nonstopmode -halt-on-error -output-directory=%o %F")
         :image-converter
           ("convert -density 300 -trim -quality 90 %F %O"))))

(provide 'settings)

