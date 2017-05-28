
;;; This file bootstraps the configuration, which is divided into
;;; a number of other files.


;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(require 'package)
(package-initialize)

;; (setq gc-cons-threshold 100000000)

(defun load-directory (dir)
  (let ((load-it
          (lambda (f)
            (load-file (concat (file-name-as-directory dir) f)))))
    (mapc load-it (directory-files dir nil "\\.el$"))))

(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
(add-to-list 'package-archives `("melpa" . "http://melpa.org/packages/"))

(defun require-package (package &optional min-version no-refresh)
  "Install given PACKAGE, optionally requiring MIN-VERSION.
If NO-REFRESH is non-nil, the available package lists will not be
re-downloaded in order to locate PACKAGE."
  (if (package-installed-p package min-version)
      t
    (if (or (assoc package package-archive-contents) no-refresh)
        (if (boundp 'package-selected-packages)
            ;; Record this as a package the user installed explicitly
            (package-install package nil)
          (package-install package))
      (progn
        (package-refresh-contents)
        (require-package package min-version t)))))

(defun maybe-require-package (package &optional min-version no-refresh)
  "Try to install PACKAGE, and return non-nil if successful.
In the event of failure, return nil and print a warning message.
Optionally require MIN-VERSION.  If NO-REFRESH is non-nil, the
available package lists will not be re-downloaded in order to
locate PACKAGE."
  (condition-case err
      (require-package package min-version no-refresh)
    (error
     (message "Couldn't install package `%s': %S" package err)
     nil)))


(defun install-packages (package-list)
  "Install all the packages there"
  (mapcar #'require-package package-list))

(defun from-emacsd
    (str)
  "from .emacs.d"
  (convert-standard-filename
   (expand-file-name
    (concat "~/.emacs.d/" str))))

(defun to-file
		(str)
	"standardisation of the filename"
	(convert-standard-filename
   (expand-file-name str)))

(add-to-list 'load-path
						 (from-emacsd "vendor/"))

(require 'use-package)

(use-package diminish :ensure)

;;; Fire up package.el
(setq package-enable-at-startup nil)

(load-file (from-emacsd "init/languages.el"))
(load-file (from-emacsd "init/preferences.el"))
(load-file (from-emacsd "init/add-path.el"))
(load-file (from-emacsd "init/misc.el"))
(load-file (from-emacsd "init/themes.el"))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
	 (quote
		("6de7c03d614033c0403657409313d5f01202361e35490a3404e33e46663c2596" "3c98d13ae2fc7aa59f05c494e8a15664ff5fe5db5256663a907272869c4130dd" "71182be392aa922f3c05e70087a40805ef2d969b4f8f965dfc0fc3c2f5df6168" "5436e5df71047d1fdd1079afa8341a442b1e26dd68b35b7d3c5ef8bd222057d1" default)))
 '(initial-frame-alist (quote ((fullscreen . maximized))))
 '(package-selected-packages
	 (quote
		(coffee-mode robe inf-ruby monokai-theme darkokai-theme gruvbox-theme leuven-theme omnisharp smart-tabs-mode sass-mode matlab-mode darktooth-theme adjust-parens clj-refactor aggressive-indent markdown-mode counsel-projectile helm flatland-theme smex smartparens projectile powerline multiple-cursors js2-mode highlight-parentheses flycheck-irony diminish company-irony cider arduino-mode ample-theme))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
