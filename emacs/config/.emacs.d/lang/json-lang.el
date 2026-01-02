;;; json-lang.el --- Summary
;;
;;; Commentary:
;;    eglot by default uses vscode-json-languageserver, which should be installed manually using
;;    npm -g vscode-json-languageserver or caifs add vscode-json-languageserver
;;; Code:

(use-package json-ts-mode
    :ensure nil
    :mode (("\\.json\\'"   . json-ts-mode)
         ("\\.jsonc\\'"  . json-ts-mode))
    :custom
    (js-ts-mode-indent-offset 2))

(provide 'json-lang)
;;; json-lang.el ends here
