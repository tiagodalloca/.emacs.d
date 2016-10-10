(add-to-list 'exec-path
             (convert-standard-filename (expand-file-name "~/.emacs.d/path/MingW/bin/")))
(add-to-list 'exec-path
             (convert-standard-filename (expand-file-name "~/.emacs.d/path/MingW/bin/")))
(add-to-list 'exec-path
             (convert-standard-filename (expand-file-name "~/.emacs.d/path/")))

(setenv "PATH" (concat (getenv "PATH") ";"
                       (convert-standard-filename (expand-file-name "~/.emacs.d/path/MingW/bin/")) ";"
                       (convert-standard-filename (expand-file-name "~/.emacs.d/path/MingW/msys/bin/")) ";"
                       (convert-standard-filename (expand-file-name "~/.emacs.d/path/")) ";"))
