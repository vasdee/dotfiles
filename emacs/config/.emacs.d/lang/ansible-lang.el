;;; ansible-lang.el --- Summary
;;
;;; Commentary:
;;
;;; Code:

;; enable ansible mode when yaml-mode is activated and an ansible.cfg file is present within the project root
;; for the minute, lets just enable it manually
(use-package ansible
    :ensure t
    :hook
    (
        (ansible-mode-hook . eglot-ensure)
        ((yaml-mode-hook) . (lambda ()
                                (when (my/marker-file-in-project "ansible.cfg") (ansible-mode t)))))
)

(provide 'ansible-lang)
;;; ansible-lang.el ends here
