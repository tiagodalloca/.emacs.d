(require 'package)
(package-initialize)

(setq gc-cons-threshold 100000000)

(defun load-directory (dir)
  (let ((load-it
          (lambda (f)
            (load-file (concat (file-name-as-directory dir) f)))))
    (mapc load-it (directory-files dir nil "\\.el$"))))

(defun from-emacsd
    (str)
  "from .emacs.d"
  (convert-standard-filename
   (expand-file-name
    (concat "~/.emacs.d/" str))))

(load-directory (from-emacsd "vendor/"))

(require 'use-package)
(require 'diminish)
(setq package-enable-at-startup nil)

(load-file (from-emacsd "init/languages.el"))
(load-file (from-emacsd "init/add-path.el"))
(load-file (from-emacsd "init/themes.el"))

;; NO WELCOME SCREEN
(setq inhibit-startup-screen t)

;; FONTS
;; SCREEN SIZE
(add-to-list 'default-frame-alist '(width  . 100))
(add-to-list 'default-frame-alist '(height . 30))
(add-to-list 'default-frame-alist '(font . "Consolas-12"))


;; do not confirm a new file or buffer
(setq confirm-nonexistent-file-or-buffer nil)

;; ENCONDING
(prefer-coding-system 'utf-8)

;; LINE NUMBERS
(global-linum-mode)
(setq linum-format "%4d\u2502 ")

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
