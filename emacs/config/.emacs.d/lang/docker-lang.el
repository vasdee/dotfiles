;;; docker-lang.el --- Summary
;;
;;; Commentary:
;;    eglot by default uses docker-language-server as the default lsp binary.
;;; Code:

(use-package docker
  :ensure t
  :bind ("C-c d" . docker))

;; Mode for working with Dockerfile
(use-package dockerfile-ts-mode
    :ensure nil
    :mode (("Dockerfile\\'" . dockerfile-ts-mode)
              ("\\.dockerfile\\'" . dockerfile-ts-mode))
;    :config
;    (add-to-list 'eglot-server-programs
;        '((docker-mode) . ("docker-language-server" "start" "--stdio")))
    :hook
    (docker-ts-mode-hook . eglot-ensure)
)

(provide 'docker-lang)
;;; docker-lang.el ends here
