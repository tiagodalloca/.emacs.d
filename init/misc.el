;; Use smex to handle M-x
(use-package smex :ensure)

(use-package counsel :ensure)

(use-package swiper :ensure
  :defer t)

(use-package ag :ensure
  :defer t)

(use-package counsel-projectile :ensure)

(use-package ivy :ensure
  :diminish (ivy-mode . "")
  :bind
  (( "\C-s"    . swiper)
   ( "C-S-s"   . swiper-all)
   ( "C-c C-r" . ivy-resume)
   ( "C-x b"   . ivy-switch-buffer)
   ( "C-x C-b" . ivy-switch-buffer)
   ( "M-x"     . counsel-M-x)
   ( "C-x C-f" . counsel-find-file)
   ( "<f1> f"  . counsel-describe-function)
   ( "<f1> v"  . counsel-describe-variable)
   ( "<f2> i"  . counsel-info-lookup-symbol)
   ( "<f2> u"  . counsel-unicode-char)
   ( "C-c g"   . counsel-git)
   ( "C-c j"   . counsel-git-grep)
   ( "C-c k"   . counsel-ag)
   ( "C-x l"   . counsel-locate)
   ( "C-S-o"   . counsel-rhythmbox))
  :init
  (ivy-mode 1)
  :config
  (progn
    (setq ivy-use-virtual-buffers t)
    (setq ivy-count-format "")
    (setq ivy-height 10)
    (eval-after-load 'counsel-projectile
      '(progn
				 (counsel-projectile-mode)))))

(use-package flycheck :ensure
  :defer t
  :init
  (add-hook 'prog-mode-hook #'flycheck-mode)
  :diminish flycheck-mode)

(use-package multiple-cursors :ensure
  :init
  (global-set-key (kbd "C-S-<mouse-1>") 'mc/add-cursor-on-click))

(use-package projectile :ensure 
  :commands (dired-mode
             help-mode
             projectile-mode)	
  :init
  (progn (projectile-global-mode)
				 (setq projectile-indexing-method 'alien))
  :diminish 'projectile-mode)


(use-package powerline :ensure
  :config
  (powerline-default-theme))

(defun append-exec-path ()
  "Append projectiles directories to 'exec-path'."
  (when (functionp 'projectile-get-project-directories)
    (when (projectile-project-p)
      (dolist (path-dir (projectile-get-project-directories))
        (setq exec-path (append exec-path (list path-dir)))))))

(use-package company :ensure
  :defer t
  :init
  (progn
    (add-hook 'after-init-hook 'global-company-mode)
    (setq company-dabbrev-downcase 0)
    (setq company-idle-delay 0)
    (global-company-mode)
    (diminish 'company-mode))  
  :bind
  (("S-SPC" . company-complete)))

(use-package yasnippet :ensure
	:defer t
	:bind
	(:map
	 yas-minor-mode-map
	 ("C-c <tab>" . company-yasnippet))
	:init
	(yas-global-mode 1)
	:diminish 'yas-minor-mode)

(use-package s :ensure
	:defer t)

(use-package abbrev
  :defer t
  :diminish 'abbrev-mode)

