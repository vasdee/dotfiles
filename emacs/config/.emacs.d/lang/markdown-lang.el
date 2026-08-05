;;; markdown-lang.el --- Summary
;;
;;; Commentary:
;;
;;; Code:

(use-package markdown-mode
    :ensure t
    :config
    (setq markdown-command  "pandoc --metadata=title=markdown --template=GitHub.html5 --from gfm --to html5 --mathjax --highlight-style=pygments --standalone")
    ;; always open the preview window at the right
    (setq markdown-split-window-direction 'right)
    (with-eval-after-load 'eglot
        (add-to-list 'eglot-server-programs
            '(markdown-mode . ("rumdl" "server" "--stdio"))))
    (with-eval-after-load 'flycheck
        (add-to-list 'flycheck-disabled-checkers '(markdown-markdownlint-cli markdown-markdownlint-cli2 markdown-pymarkdown))
        (add-to-list 'flycheck-checkers 'markdown-mdl)
        (setq flycheck-markdown-mdl-executable "rumdl check")
    )

    :commands (gfm-mode markdown-mode)
    :mode (("\\.md\\'" . gfm-mode))
    :hook
    ((markdown-mode-hook . eglot-ensure)
        ( markdown-hook . editorconfig-mode)
        ( markdown-hook . auto-fill-mode)
        (markdown-mode-hook . flyspell-mode))
    :bind (:map markdown-mode-map
          ("C-c C-e" . markdown-do))
)

(provide 'markdown-lang)
;;; markdown-lang.el ends here
