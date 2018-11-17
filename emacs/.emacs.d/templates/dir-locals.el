(
 ;; 
 ;; pip install python-language-server
 ;; or if using jedi
 ;; pip install jedi
    (python-mode 
     . (
	(eval . (message "Project dir is `%s'" project-root))

        (eval . (pyvenv-activate (concat project-root "backend/venv/")))
        (eval . (setq elpy-set-project-root (concat project-root "/backend/")))
        )
     )
    (nil
     . (
	;; Set the project root. 
	(eval . (setq project-root "/home/vasdee/work/dev/crew_rostering/"))
	;(eval . (setq flycheck-javascript-eslint-executable "frontend/node_modules/.bin/eslint"))
	(eval . (add-to-list 'exec-path "/home/vasdee/work/dev/crew_rostering/frontend/node_modules/.bin/"))
	;; add node modules bin folder to the path
	(eval . (progn (add-to-list 'exec-path (concat (locate-dominating-file default-directory ".dir-locals.el") "frontend/node_modules/.bin/"))))
	)
     )
 ;; Requiress the following for the lsp protocol
 ;; npm install --save-dev javascript-typescript-langserver
    (rjsx-mode
     . (
	;(eval . (#'add-node-modules-path))
	(eval . (add-to-list 'exec-path "/home/vasdee/work/dev/crew_rostering/frontend/node_modules/.bin/"))
       )
    )
)
 
;;(setq tide-tsserver-executable "node_modules/typescript/bin/tsserver"
;;      tide-tsserver-directory  "node_modules/typescript/lib")
;;(eval . (neotree-change-root "/home/vasdee/work/dev/crew_rostering/"))


;; FROM https://github.com/emacs-lsp/lsp-javascript/issues/17
;(setenv "PATH" (concat "/usr/local/bin:" (getenv "PATH")))
;(push "/usr/local/bin" exec-path)
