(in-package :nyxt)

(defvar *config-dir*
  (make-pathname
   :directory (append
	       (pathname-directory (uiop:xdg-config-home))
	       '("nyxt"))))

(defun config-file (file)
  "Return the absolute namestring for FILE in the config directory."
  (make-pathname
   :directory (pathname-directory *config-dir*)
   :name file
   :type "lisp"))

(load-after-system :slynk (config-file "slynk"))
(load (config-file "keybindings"))
