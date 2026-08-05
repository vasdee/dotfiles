;;; python-lang.el --- Summary
;;
;;; Commentary:
;;
;;; Code:

(use-package python-mode
    :ensure t
    :config
    (py-underscore-word-syntax-p-off)
    ;(add-to-list 'flycheck-disabled-checkers '(python-flake8 python-mypy))
    ;(add-to-list 'flycheck-checkers 'python-ruff)
    (eldoc-mode t)
    ;; Map Python buffers to the native 'ruff server'
    ;(setf (alist-get 'python-mode flycheck-lsp-servers) '("ruff" "server"))
    ;(setf (alist-get 'python-ts-mode flycheck-lsp-servers) '("ruff" "server")))

;; Multiplex basedpyright-langserver with ty
    (with-eval-after-load 'eglot
    (add-to-list 'eglot-server-programs
        '((python-mode python-ts-mode) . ("rass" "--" "basedpyright-langserver" "--stdio" "--" "ty" "server")))
    (setq-default eglot-workspace-configuration
        '((:pyright . (:venvPath ".venv" :pythonPath ".")))))
    :hook
    ((python-mode-hook python-ts-mode-hook) . eglot-ensure)
)

(provide 'python-lang)
;;; python-lang.el ends here
