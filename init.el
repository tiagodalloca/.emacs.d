
;;; This file bootstraps the configuration, which is divided into
;;; a number of other files.


;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.

(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  (when no-ssl
    (warn "\
Your version of Emacs does not support SSL connections,
which is unsafe because it allows man-in-the-middle attacks.
There are two things you can do about this warning:
1. Install an Emacs version that does support SSL and be safe.
2. Remove this warning from your init file so you won't see it again."))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  ;; (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  (add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (add-to-list 'package-archives (cons "gnu" "http://elpa.gnu.org/packages/")))
  ;; (when (< emacs-major-version 24)
  ;;   ;; For important compatibility libraries like cl-lib
  ;;   (add-to-list 'package-archives (cons "gnu" (concat proto "://elpa.gnu.org/packages/")))))
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
 '(custom-safe-themes
	 (quote
		("d91ef4e714f05fff2070da7ca452980999f5361209e679ee988e3c432df24347" "c63a789fa2c6597da31f73d62b8e7fad52c9420784e6ec34701ae8e8f00071f6" "fd24b2c570dbd976e17a63ba515967600acb7d2f9390793859cb82f6a2d5dacd" "82fce2cada016f736dbcef237780516063a17c2436d1ee7f42e395e38a15793b" "858a353233c58b69dbe3a06087fc08905df2d8755a0921ad4c407865f17ab52f" "6de7c03d614033c0403657409313d5f01202361e35490a3404e33e46663c2596" "3c98d13ae2fc7aa59f05c494e8a15664ff5fe5db5256663a907272869c4130dd" "71182be392aa922f3c05e70087a40805ef2d969b4f8f965dfc0fc3c2f5df6168" "5436e5df71047d1fdd1079afa8341a442b1e26dd68b35b7d3c5ef8bd222057d1" default)))
 '(initial-frame-alist (quote ((fullscreen . maximized))))
 '(package-selected-packages
	 (quote
		(flycheck-clj-kondo twilight-bright-theme twilight-bright-thme lenlen-theme ample-light ample-light-theme solarized-theme typescript-mode riscv-mode irony haskell-mode elpy coffee-mode robe inf-ruby monokai-theme darkokai-theme gruvbox-theme leuven-theme omnisharp smart-tabs-mode sass-mode matlab-mode darktooth-theme adjust-parens clj-refactor aggressive-indent markdown-mode counsel-projectile helm flatland-theme smex smartparens projectile powerline multiple-cursors js2-mode highlight-parentheses flycheck-irony diminish company-irony cider arduino-mode ample-theme)))
 '(safe-local-variable-values
	 (quote
		((eval font-lock-add-keywords nil
					 (\`
						(((\,
							 (concat "("
											 (regexp-opt
												(quote
												 ("sp-do-move-op" "sp-do-move-cl" "sp-do-put-op" "sp-do-put-cl" "sp-do-del-op" "sp-do-del-cl"))
												t)
											 "\\_>"))
							1
							(quote font-lock-variable-name-face)))))))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
