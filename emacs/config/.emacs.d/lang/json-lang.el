;;; json-lang.el --- Summary
;;
;;; Commentary:
;;
;;; Code:

(use-package json-mode
  :ensure t
  :config
  (setq js-indent-level 2)
  :init
  (add-to-list 'auto-mode-alist '("\\.json$" . json-mode))
  )


(provide 'json-lang)
;;; json-lang.el ends here
