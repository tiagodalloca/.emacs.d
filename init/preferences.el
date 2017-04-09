;; NO WELCOME SCREEN
(setq inhibit-startup-screen t)

;;TABS

(defun my-generate-tab-stops (&optional width max)
  "Return a sequence suitable for `tab-stop-list'."
  (let* ((max-column (or max 200))
         (tab-width (or width tab-width))
         (count (/ max-column tab-width)))
    (number-sequence tab-width (* tab-width count) tab-width)))

(setq-default indent-tabs-mode t)
(setq-default tab-width 2)
(setq-default c-basic-offset 2)
;; (setq tab-stop-list (my-generate-tab-stops))
;; (global-set-key (kbd "<tab>") 'tab-to-tab-stop)
;; (electric-indent-mode -1)

;; FONTS
(defun font-exists-p (font)
	"check if font exists"
	(if (null (x-list-fonts font))
			nil t))
(defun set-font-if-exists (font)
	"set font if it exists"
	(if (font-exists-p font)
			(set-face-attribute 'default nil :font font)))

(set-face-attribute 'default nil :font "Monospace-12")
(set-font-if-exists "Ubuntu Mono-12")

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
  :config
  (progn
    (global-hl-line-mode 1))
  :diminish 'highlight-parentheses-mode)

;; MAXIMIZED SCREEN
(custom-set-variables
 '(initial-frame-alist (quote ((fullscreen . maximized)))))

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

