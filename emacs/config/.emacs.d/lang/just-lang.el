;;; just-lang.el --- Summary
;;
;;; Commentary:
;;
;;; Code:

(use-package just-ts-mode
  ;:init (just-ts-mode-install-grammar)
  :ensure t
  :config
  ;; Install the justfile tree-sitter grammar if not already present
    (unless (treesit-language-available-p 'just)
        (just-ts-mode-install-grammar))
    (setq-default indent-tabs-mode nil)
    (add-to-list 'auto-mode-alist '("\\.just$" . just-ts-mode))
     (with-eval-after-load 'eglot
         (add-to-list 'eglot-server-programs
             '((just-ts-mode just-mode) . ("just-lsp"))))
    :hook
    (just-ts-mode-hook . eglot-ensure)
)

(provide 'just-lang)
;;; just-lang.el ends here
