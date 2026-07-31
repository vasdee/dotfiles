;;; yaml-lang.el --- Summary
;;
;;; Commentary:
;;
;;; Code:

(use-package yaml-mode
    :ensure t
    :init
    (add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
    (add-to-list 'auto-mode-alist '("\\.yaml$" . yaml-mode))
    :config
    (with-eval-after-load 'eglot
        (add-to-list 'eglot-server-programs
            '((yaml-mode) . ("yaml-language-server" "--stdio"))))
    :hook
        ((yaml-mode-hook) .
        (lambda () (unless (my/marker-file-in-project "ansible.cfg") (eglot-ensure))))
)


(provide 'yaml-lang)
;;; yaml-lang.el ends here
