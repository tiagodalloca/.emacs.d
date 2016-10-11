(defun from-emacsd
    (str)
  "from .emacs.d"
  (convert-standard-filename
   (expand-file-name
    (concat "~/.emacs.d/" str))))


(when (maybe-require-package 'company-c-headers)
  (progn
    (require 'company)
    (require 'company-c-headers) 
    (add-to-list 'company-backends 'company-c-headers)
    (add-to-list 'company-c-headers-path-system
                 (from-emacsd "/path/MingW/include/"))))
