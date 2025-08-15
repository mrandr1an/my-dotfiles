(require 'org)

(setq org-latex-preview-live t)
(setq org-preview-latex-image-directory "/home/chris/Documents/Images/LatexPreviewImages/")
(plist-put org-format-latex-options :scale 1.5)


(provide 'org-latex)
