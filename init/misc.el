;; Use smex to handle M-x
;; (use-package smex
;;   :config
;;   ;; Change path for ~/.smex-items
;;   (progn
;;     (setq-default smex-save-file (expand-file-name ".smex-items" user-emacs-directory))
;;     (global-set-key [remap execute-extended-command] 'smex)))

(use-package ivy
  :defer t
  :config
  (ivy-mode 1)
  :bind
  (( "\C-s"     . swiper)
   ( "C-c C-r"  . ivy-resume)
   ( "<f6>"     . ivy-resume)
   (  "M-x"     . counsel-M-x)
   (  "C-x C-f" . counsel-find-file)
   (  "<f1> f"  . counsel-describe-function)
   (  "<f1> v"  . counsel-describe-variable)
   (  "<f1> l"  . counsel-load-library)
   (  "<f2> i"  . counsel-info-lookup-symbol)
   (  "<f2> u"  . counsel-unicode-char)
   (  "C-c g"   . counsel-git)
   (  "C-c j"   . counsel-git-grep)
   (  "C-c k"   . counsel-ag)
   (  "C-x l"   . counsel-locate)
   (  "C-S-o"   . counsel-rhythmbox))
  :config
  (progn
    (setq ivy-use-virtual-buffers t))
  :diminish 'ivy-mode)

(use-package flycheck
  :defer t
  :config
  (add-hook 'prog-mode-hook #'flycheck-mode)
  :diminish flycheck-mode)

(use-package multiple-cursors
  :config
  (global-set-key (kbd "C-S-<mouse-1>") 'mc/add-cursor-on-click))

(use-package projectile
  :defer t
  :commands (dired-mode
             help-mode
             projectile-mode)
  :init
  (projectile-global-mode)
  :diminish 'projectile-mode)


(use-package powerline
  :config
  (powerline-default-theme))

; (when (maybe-require-package 'smart-mode-line)
;   (when (maybe-require-package 'smart-mode-line-powerline-theme)
;     (setq powerline-arrow-shape 'curve)
;     (setq sml/theme 'powerline)
;     (setq sml/no-confirm-load-theme t)
;     (sml/setup)))

; (add-to-list 'load-path "~/.emacs.d/emacs-powerline/")
; (require 'powerline)
; (require 'cl)
; (setq powerline-arrow-shape 'arrow14)

(defun append-exec-path ()
  "Append projectiles directories to 'exec-path'."
  (when (functionp 'projectile-get-project-directories)
    (when (projectile-project-p)
      (dolist (path-dir (projectile-get-project-directories))
        (setq exec-path (append exec-path (list path-dir)))))))

(use-package company
  :defer t
  :config
  (progn
    (add-hook 'after-init-hook 'global-company-mode)
    (setq company-dabbrev-downcase 0)
    (setq company-idle-delay 0)
    (global-company-mode)
    (diminish 'company-mode))  
  :bind
  (("S-SPC" . company-complete)))

(use-package abbrev
  :defer t
  :diminish 'abbrev-mode)
