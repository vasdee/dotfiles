;;; docker-lang.el --- Summary
;;
;;; Commentary:
;;
;;; Code:

(use-package docker
  :ensure t
  :bind ("C-c d" . docker))

;; Mode for working with Dockerfile
(use-package dockerfile-mode
    :ensure t
    :config
    (add-to-list 'eglot-server-programs
        '((docker-mode) . ("docker-language-server" "start" "--stdio")))
    :hook
    (docker-mode-hook . eglot-ensure)
)

(provide 'docker-lang)
;;; docker-lang.el ends here
