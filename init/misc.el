;; Use smex to handle M-x
(when (maybe-require-package 'smex)
  ;; Change path for ~/.smex-items
  (setq-default smex-save-file (expand-file-name ".smex-items" user-emacs-directory))
  (global-set-key [remap execute-extended-command] 'smex))


(when (maybe-require-package 'flycheck)
  (use-package flycheck
    :config
    (progn
      (global-flycheck-mode)
      (diminish 'flycheck-mode))))

(when (maybe-require-package 'multiple-cursors)
  (require 'multiple-cursors)
  (global-set-key (kbd "C-S-<mouse-1>") 'mc/add-cursor-on-click))

(when (maybe-require-package 'projectile)
  (use-package projectile
    :config
    (projectile-global-mode)
    :diminish 'projectile-mode))


(when (maybe-require-package 'powerline)
  (require 'powerline)
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

(when (maybe-require-package 'company)
  (use-package company
   :config
   (progn
     (add-hook 'after-init-hook 'global-company-mode)
     (setq company-dabbrev-downcase 0)
     (setq company-idle-delay 0)
     (global-company-mode)
     (diminish 'company-mode))  
    :bind
    (("S-SPC" . company-complete))))

(use-package abbrev
  :diminish 'abbrev-mode)
