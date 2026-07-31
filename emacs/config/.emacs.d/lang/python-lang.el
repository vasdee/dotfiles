;;; python-lang.el --- Summary
;;
;;; Commentary:
;;
;;; Code:

(use-package python-mode
    :ensure t
    :config
    (py-underscore-word-syntax-p-off)
    (add-to-list 'flycheck-disabled-checkers '(python-flake8 python-mypy))
    (add-to-list 'flycheck-checkers 'python-ruff)
    (eldoc-mode t)
    (add-to-list 'eglot-server-programs
        '(python-mode . ,(eglot-alternatives '(("basedpyright-langserver" "--stdio")))))
    (setq-default eglot-workspace-configuration
        '((:pyright . (:venvPath ".venv" :pythonPath "."))))
    :hook
    ((python-mode-hook python-ts-mode-hook) . eglot-ensure)
)

(provide 'python-lang)
;;; python-lang.el ends here
