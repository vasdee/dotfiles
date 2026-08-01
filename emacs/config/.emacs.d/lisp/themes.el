;;; themes.el --- Summary
;;
;;; Commentary:
;;
;;; Code:

(use-package spacemacs-theme
    :ensure t
)

(use-package color-theme-sanityinc-tomorrow
    :ensure t
)

(use-package doom-themes
    :ensure t
    :custom
    (doom-themes-enable-bold nil)   ; if nil, bold is universally disabled
    (doom-themes-enable-italic nil) ; if nil, italics is universally disabled
)

(use-package material-theme
    :ensure t
)

(use-package dracula-theme
    :ensure t
)


(provide 'themes)
;;; themes.el ends here
