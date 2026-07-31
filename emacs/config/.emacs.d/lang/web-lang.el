;;; web-lang.el --- Summary
;;
;;; Commentary:
;;
;;; Code:

;; Built in package for supporting JS/HTML etc.
;; This is configured to use type script which works well with react
(use-package web-mode
  :ensure t
  :init
    (add-to-list 'auto-mode-alist '("\\.ts$" . web-mode))
    (add-to-list 'auto-mode-alist '("\\.tsx$" . web-mode))
    (add-to-list 'auto-mode-alist '("\\.html"   . web-mode))
  :config
    (setq web-mode-enable-auto-quoting nil)
    (setq web-mode-markup-indent-offset 2)
    (setq web-mode-code-indent-offset 2)
    (setq web-mode-attr-indent-offset 2)
    (setq web-mode-attr-value-indent-offset 2)
)

(provide 'web-langl)
;;; web-lang.el ends here
