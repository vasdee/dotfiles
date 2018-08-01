(
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
	(eval . (progn
                (require 'find-file-in-project)
                (setq ffip-prune-patterns `("*/htmlcov/*", "*/venv/*", "*/node_modules/*"))))
       )
   )
)
 
  
;; (setq tide-tsserver-executable "node_modules/typescript/bin/tsserver")

;;(setq tide-tsserver-executable "node_modules/typescript/bin/tsserver"
;;      tide-tsserver-directory  "node_modules/typescript/lib")
;;(eval . (neotree-change-root "/home/vasdee/work/dev/crew_rostering/"))
