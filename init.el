
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

