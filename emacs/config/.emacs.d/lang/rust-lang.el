;;; rust-lang.el --- Summary
;;
;;; Commentary:
;;
;;; Code:

(use-package rust-mode
    :ensure t
    :init
    (setq rust-format-on-save t)
    (setq rust-mode-treesitter-derive t)
    :hook
    (rust-mode-hook . eglot-ensure)
)

;;;(use-package rustic
;;;  :ensure t
;;;  :after rust-mode
;;;  :mode ("\\.rs\\'" . rustic-mode)
;;;  :custom
;;;  (rustic-cargo-use-last-stored-arguments t)
;;;  :config
;;;  (setq rustic-format-on-save nil)
;;;  (setq rustic-lsp-client 'eglot)
;;;    (add-hook 'eglot--managed-mode-hook (lambda () (flymake-mode -1)))
;;; )


(provide 'rust-lang)
;;; rust-lang.el ends here
