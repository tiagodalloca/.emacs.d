(add-to-list 'exec-path
             (from-emacsd "path/MingW/bin/"))
(add-to-list 'exec-path
             (from-emacsd "path/MingW/msys/bin/"))
(add-to-list 'exec-path
             (from-emacsd "path/"))
(add-to-list 'exec-path
             (from-emacsd "path/CMake/bin/"))
(add-to-list 'exec-path
             (from-emacsd "path/LLVM/bin/"))

(add-to-list 'exec-path  (to-file
													(concat (getenv "USERPROFILE")
																	"/.lein/self-installs/")))

(add-to-list 'exec-path (to-file
												 (concat (getenv "USERPROFILE")
																 "/AppData/Local/Programs/Git/bin/")))

(setenv "PATH" (concat (getenv "PATH") ";"
                       (from-emacsd "path/MingW/bin/")
											 ";"
                       (from-emacsd "path/MingW/msys/bin/")
											 ";"
                       (from-emacsd "path/")
											 ";"
                       (from-emacsd "path/LLVM/bin/")
											 ";"
                       (from-emacsd "path/CMake/bin/")
											 ";"
											 (to-file
												(concat (getenv "USERPROFILE")
																"/.lein/self-installs/"))
											 ";"
											 (to-file
												(concat (getenv "USERPROFILE")
																"/AppData/Local/Programs/Git/bin/"))))

