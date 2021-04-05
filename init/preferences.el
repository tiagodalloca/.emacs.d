;; NO WELCOME SCREEN
(setq inhibit-startup-screen t)

;;TABS

(setq-default tab-width 2
							c-basic-offset 2
							indent-tabs-mode t)

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
	(when (and (window-system) (font-exists-p "Fira Code-12"))
		(progn (set-frame-font "Fira Code-12")
					 (use-package fira-code-mode
						 :custom (fira-code-mode-disabled-ligatures '("[]" "x"))
						 :hook prog-mode))))

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

(defun fullscreen (&optional f)
	(interactive)
	(x-send-client-message nil 0 nil "_NET_WM_STATE" 32
												 '(2 "_NET_WM_STATE_MAXIMIZED_VERT" 0))
	(x-send-client-message nil 0 nil "_NET_WM_STATE" 32
												 '(2 "_NET_WM_STATE_MAXIMIZED_HORZ" 0)))

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


;; FIRA CODE

(defun fira-code-mode--make-alist (list)
  "Generate prettify-symbols alist from LIST."
  (let ((idx -1))
    (mapcar
     (lambda (s)
       (setq idx (1+ idx))
       (let* ((code (+ #Xe100 idx))
							(width (string-width s))
							(prefix ())
							(suffix '(?\s (Br . Br)))
							(n 1))
				 (while (< n width)
					 (setq prefix (append prefix '(?\s (Br . Bl))))
					 (setq n (1+ n)))
				 (cons s (append prefix suffix (list (decode-char 'ucs code))))))
     list)))

(defconst fira-code-mode--ligatures
  '("www" "**" "***" "**/" "*>" "*/" "\\\\" "\\\\\\"
    "{-" "[]" "::" ":::" ":=" "!!" "!=" "!==" "-}"
    "--" "---" "-->" "->" "->>" "-<" "-<<" "-~"
    "#{" "#[" "##" "###" "####" "#(" "#?" "#_" "#_("
    ".-" ".=" ".." "..<" "..." "?=" "??" ";;" "/*"
    "/**" "/=" "/==" "/>" "//" "///" "&&" "||" "||="
    "|=" "|>" "^=" "$>" "++" "+++" "+>" "=:=" "=="
    "===" "==>" "=>" "=>>" "<=" "=<<" "=/=" ">-" ">="
    ">=>" ">>" ">>-" ">>=" ">>>" "<*" "<*>" "<|" "<|>"
    "<$" "<$>" "<!--" "<-" "<--" "<->" "<+" "<+>" "<="
    "<==" "<=>" "<=<" "<>" "<<" "<<-" "<<=" "<<<" "<~"
    "<~~" "</" "</>" "~@" "~-" "~=" "~>" "~~" "~~>" "%%"
    "x" ":" "+" "+" "*"))

(defvar fira-code-mode--old-prettify-alist)

(defun fira-code-mode--enable ()
  "Enable Fira Code ligatures in current buffer."
  (setq-local fira-code-mode--old-prettify-alist prettify-symbols-alist)
  (setq-local prettify-symbols-alist (append (fira-code-mode--make-alist fira-code-mode--ligatures) fira-code-mode--old-prettify-alist))
  (prettify-symbols-mode t))

(defun fira-code-mode--disable ()
  "Disable Fira Code ligatures in current buffer."
  (setq-local prettify-symbols-alist fira-code-mode--old-prettify-alist)
  (prettify-symbols-mode -1))

(define-minor-mode fira-code-mode
  "Fira Code ligatures minor mode"
  :lighter " Fira Code"
  (setq-local prettify-symbols-unprettify-at-point 'right-edge)
  (if fira-code-mode
      (fira-code-mode--enable)
    (fira-code-mode--disable)))

(defun fira-code-mode--setup ()
  "Setup Fira Code Symbols"
  (set-fontset-font t '(#Xe100 . #Xe16f) "Fira Code Symbol"))

(provide 'fira-code-mode)

(when (display-graphic-p)
	(load-font))

