;; NO WELCOME SCREEN
(setq inhibit-startup-screen t)

;;TABS

(setq-default tab-width 2
							c-basic-offset 2
							indent-tabs-mode t)

(setq-default indent-tabs-mode nil)

;; FONTS
(defun font-exists-p (font)
	"check if font exists"
	(if (null (x-list-fonts font))
			nil t))
(defun set-font-if-exists (font)
	"set font if it exists"
	(if (font-exists-p font)
			(set-face-attribute 'default (selected-frame) :font font)))

(defun load-font () 
	(set-face-attribute 'default nil :font "Monospace-12")
	(set-font-if-exists "Consolas-13")
	(set-font-if-exists "Ubuntu Mono-14")
	(set-font-if-exists "Fira Code-12"))

;; DON'T FORGET DO DOWNLOAD FIRA CODE FONT
;; AND https://github.com/tonsky/FiraCode/files/412440/FiraCode-Regular-Symbol.zip

(require 'fira-code-mode)

(defun is-not-windows-so? ()
	"Am I running on windows?"
	(not (string-match-p "Windows" (getenv "PATH"))))

(add-hook 'prog-mode-hook
					(lambda ()
						(when (and (window-system) 
											 (font-exists-p "Fira Code-12")
											 ;; (is-not-windows-so?)
											 )
							(progn
								(setq fira-code-mode-disabled-ligatures '("[]" "x" ":=" ":-"))
								(fira-code-mode)
								(diminish 'fira-code-mode)))))

;; do not confirm a new file or buffer
(setq confirm-nonexistent-file-or-buffer nil)

;; ENCONDING
(prefer-coding-system 'utf-8)

;; LINE NUMBERS
(global-linum-mode)
;; (setq linum-format "%4d\u2502 ")
(setq linum-format "%4d ")

;; HIGHLIGHT CURRENT LINE
(use-package hl-line
  :init
  (progn
    (global-hl-line-mode 1))
  :diminish 'highlight-parentheses-mode)

;; MAXIMIZED SCREEN
(require 'maxframe)
(defun fullscreen (&optional f)
	(interactive)
	(x-send-client-message nil 0 nil "_NET_WM_STATE" 32
												 '(2 "_NET_WM_STATE_MAXIMIZED_VERT" 0))
	(x-send-client-message nil 0 nil "_NET_WM_STATE" 32
												 '(2 "_NET_WM_STATE_MAXIMIZED_HORZ" 0)))

;; TEMP FILES LOCATION
;; Save all tempfiles in $TMPDIR/emacs$UID/
(defconst emacs-tmp-dir (format "%s/%s%s/" temporary-file-directory "emacs" (user-uid)))
(setq backup-directory-alist
      `((".*" . ,emacs-tmp-dir)))
(setq auto-save-file-name-transforms
      `((".*" ,emacs-tmp-dir t)))
(setq auto-save-list-file-prefix
      emacs-tmp-dir)

;; NO TOOLBAR
(tool-bar-mode -1)

;; NO SCROLLBAR
(scroll-bar-mode -1)

;; I HATE THOSE ALARMS
(setq ring-bell-function 'ignore)

;; BAR CURSOR
(setq-default cursor-type 'bar)

;; DELETE REGION
(delete-selection-mode 1)

;;BINDININGS
(global-set-key [f5] (lambda ()
											 (interactive)
                       (revert-buffer nil t)))

(defun on-client-connect (&optional frame)
	(select-frame frame)
	(when (and frame (display-graphic-p))
		(run-with-idle-timer
		 0.01 nil (lambda (f) (progn (x-focus-frame f)
														(raise-frame f)
														(maximize-frame)
														(fullscreen)))
		 frame)
		(load-font)))

(add-hook 'after-make-frame-functions #'on-client-connect)

(when (display-graphic-p)
	(load-font))

(setq whitespace-style '(tabs trailing space-before-tab indentation empty space-after-tab tab-mark))


;; (set-face-foreground 'whitespace-tab "gray1")
;; (global-whitespace-mode)
