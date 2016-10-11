(defun from-emacsd
    (str)
  "from .emacs.d"
  (convert-standard-filename
   (expand-file-name
    (concat "~/.emacs.d/" str))))

(add-to-list 'exec-path
             (from-emacsd "path/MingW/bin/"))
(add-to-list 'exec-path
             (from-emacsd "path/MingW/msys/bin/"))
(add-to-list 'exec-path
             (from-emacsd "path/"))
(add-to-list 'exec-path
             (from-emacsd "path/CMake/bin/"))

(setenv "PATH" (concat (getenv "PATH") ";"
                       (from-emacsd "path/MingW/bin/") ";"
                       (from-emacsd "path/MingW/msys/bin/") ";"
                       (from-emacsd "path/") ";"
                       (from-emacsd "path/CMake/bin/")))
