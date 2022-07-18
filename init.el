
;;; This file bootstraps the configuration, which is divided into
;;; a number of other files.


;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.

(require 'package)
(add-to-list 'package-archives (cons "gnu" "http://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; (setq gc-cons-threshold 100000000)

(defun load-directory (dir)
  (let ((load-it
          (lambda (f)
            (load-file (concat (file-name-as-directory dir) f)))))
    (mapc load-it (directory-files dir nil "\\.el$"))))


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

(add-to-list 'load-path (from-emacsd "vendor/"))

(require-package 'use-package)
(require 'diminish)

;;; Fire up package.el
(setq package-enable-at-startup nil)

(load-file (from-emacsd "init/languages.el"))
(load-file (from-emacsd "init/preferences.el"))
(load-file (from-emacsd "init/misc.el"))
(load-file (from-emacsd "init/themes.el"))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(company-box gruvbox-theme powerline counsel-projectile ag counsel smex tide typescript-mode haskell-mode markdown-mode aggressive-indent highlight-parentheses smartparens clj-refactor flycheck-clj-kondo clojure-mode web-mode use-package sass-mode robe php-mode emmet-mode elpy coffee-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
