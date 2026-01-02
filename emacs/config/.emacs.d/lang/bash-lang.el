;;; bash-lang.el --- Summary
;;
;;; Commentary:
;;
;;; Code:

(use-package bash-ts-mode
  :ensure t
  :mode (("\\.sh$" . bash-ts-mode)
         ("\\.bash$" . bash-ts-mode))
  :hook ((bash-ts-mode-hook . eglot-ensure)
         (sh-mode-hook . eglot-ensure))
  :config
  (with-eval-after-load 'eglot
    (add-to-list 'eglot-server-programs
      '((bash-ts-mode sh-mode) . ("bash-language-server" "start")))))

(provide 'bash-lang)
;;; bash-lang.el ends here
