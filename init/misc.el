(when (maybe-require-package 'flycheck)
   (global-flycheck-mode))

(when (maybe-require-package 'multiple-cursors)
  (require 'multiple-cursors)
  (global-set-key (kbd "C-S-<mouse-1>") 'mc/add-cursor-on-click))

(when (maybe-require-package 'projectile)
  (require 'projectile)
  (projectile-global-mode))

(when (maybe-require-package 'company)
  (global-company-mode))


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
