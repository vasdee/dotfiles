;;; rst-lang.el --- Summary  -*- lexical-binding: t; -*-
;;
;;; Commentary:
;;
;;; Code:

;; restructured text mode
(use-package rst
  :defer t
  :init
    (add-to-list 'auto-mode-alist '("\\.rst$" . rst-mode))
    (add-to-list 'auto-mode-alist '("\\.rest$" . rst-mode))
)

(provide 'rst-lang)
;;; rst-lang.el ends here
