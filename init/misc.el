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
   ( "C-S-o"   . counsel-rhythmbox)
   :map ivy-minibuffer-map
   ( "TAB"     . ivy-insert-current)
   ( "C-j"     . ivy-partial-or-done))
  :init
  (ivy-mode 1)
  :config
  (progn
    (setq ivy-use-virtual-buffers t)
    (setq ivy-count-format "")
    (setq ivy-height 10)
    (eval-after-load 'counsel-projectile
      '(progn
				 (counsel-projectile-mode)
				 (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)))))

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
  :diminish
  :init
  (progn
    (add-hook 'after-init-hook 'global-company-mode)
    (global-company-mode)
		(global-unset-key (kbd "TAB")))
  :custom
  (company-begin-commands '(self-insert-command))
  (company-idle-delay 0)
  (company-minimum-prefix-length 2)
  (company-show-numbers t)
  (company-tooltip-align-annotations 't)
  :bind
  (("TAB" . company-complete)))

(use-package company-box :ensure
  :after company
  :diminish
  :hook (company-mode . company-box-mode))

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

(setq browse-url-generic-program (executable-find "firefox"))

(defun open-koala ()
	"Hey koala."
	(interactive)
	(browse-url-generic "https://proxy.duckduckgo.com/iu/?u=http%3A%2F%2Fmomvoyage.hilton.com%2Fwp-content%2Fuploads%2F2013%2F05%2FKoala-Mother-and-Joey.jpg&f=1&nofb=1"))

(defun open-panda ()
	"Hey koala."
	(interactive)
	(browse-url-generic "https://proxy.duckduckgo.com/iu/?u=https%3A%2F%2Fsearchengineland.com%2Ffigz%2Fwp-content%2Fseloads%2F2014%2F08%2Fpanda-teeth-ss-1920.jpg&f=1&nofb=1"))

(global-set-key (kbd "C-S-M-z C-S-M-z 1") 'open-koala)
(global-set-key (kbd "C-S-M-z C-S-M-z 2") 'open-panda)
