;;; navigation.el --- Summary
;;
;;; Commentary:
;;
;;; Code:

;; Marginalia: rich annotations in completion candidates
(use-package marginalia
  ;; Bind `marginalia-cycle' locally in the minibuffer.  To make the binding
  ;; available in the *Completions* buffer, add it to the
  ;; `completion-list-mode-map'.
  :bind (:map minibuffer-local-map
         ("M-A" . marginalia-cycle))

  ;; The :init section is always executed.
  :config

  ;; Marginalia must be activated in the :init section of use-package such that
  ;; the mode gets enabled right away. Note that this forces loading the
  ;; package.
  (marginalia-mode))

;; Free form matching in the mini-buffer
(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles partial-completion))))
  (completion-category-defaults nil)
  (completion-pcm-leading-wildcard t))

;; Embark: context-sensitive actions / right-click menu
(use-package embark
  :ensure t
  :bind
  (("C-." . embark-act)
   ("C-;" . embark-dwim)
   ("C-h B" . embark-bindings))
  :init
  (setq prefix-help-command #'embark-prefix-help-command)
  :config
  (add-to-list 'display-buffer-alist
               '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
                 nil (window-parameters (mode-line-format . none)))))

(use-package embark-consult
  :ensure t
  :hook (embark-collect-mode . consult-preview-at-point-mode))

;; CORFU: Inline Popup Completion UI
(use-package corfu
  :ensure t
  ;; Optional customizations
  :custom
  (corfu-cycle t)                ; Allows cycling through candidates
  (corfu-auto t)                 ; Enable auto-completion popup window
  (corfu-auto-prefix 2)          ; Minimum numeric characters before popup shows
  (corfu-auto-delay 0.3)         ; Tiny delay before menu pops up for speed
  (corfu-quit-at-boundary 'separator) ; Never quit completion at space/separator

  :init
  (global-corfu-mode 1))

;; Recommended: Enable Corfu in the Minibuffer (e.g., for Vertico search prompts)
(use-package corfu-popupinfo
  :ensure nil ; Part of the core Corfu repository package
  :hook (corfu-mode . corfu-popupinfo-mode)
  :custom
  (corfu-popupinfo-delay '(0.2 . 0.1))) ; Quick display of documentation tooltips


;; cape: Completion At Point Extensions (Backends)
(use-package cape
  :ensure t
  :init
  ;; Add useful completion backends globally to the capf list.
  ;; Order determines priority evaluation during triggers.
  (add-hook 'completion-at-point-functions #'cape-dabbrev)     ; Words in open buffers
  (add-hook 'completion-at-point-functions #'cape-file)        ; File path system matching
  (add-hook 'completion-at-point-functions #'cape-elisp-block) ; Elisp inside org code blocks
  (add-hook 'completion-at-point-functions #'cape-keyword)     ; Programming language keywords

  :config
  ;; Optional: Silence capf errors if they cause unwanted noise in specific modes
    (setq text-mode-ispell-silent t)
)

(use-package vertico
  :ensure t
  :init
  (vertico-mode 1)
  :config
  ;; Optional: Tweak minibuffer behavior
  (setq vertico-cycle t)) ; Allow cycling from last to first candidate

;; Search and navigation commands base on the built in emacs completion functions
(use-package consult
  :ensure t
  :bind (;; Swiper replacements
         ("C-s" . consult-line)
         ("M-s l" . consult-line)
         ;; Counsel replacements
         ("C-x b" . consult-buffer)                ; Replacing ivy-switch-buffer
         ("M-y" . consult-yank-pop)               ; Replacing counsel-yank-pop
         ("C-x r b" . consult-bookmark)
         ;; Search replacements
         ("M-s g" . consult-grep)
         ("M-s r" . consult-ripgrep)
         ;; Info/Help enhancements
         ("C-h i" . consult-info)
         ;; Errors/Flycheck integration
         ("M-g g" . consult-goto-line)            ; Enhances native line jumping
         ("M-g o" . consult-outline)))            ; Replaces counsel-outline


(provide 'navigation)
;;; navigation.el ends here
