(in-package :nyxt)

(load-after-system :slynk "~/.config/nyxt/slynk.lisp")

;; (defmacro my-make-keymap (name &rest body)
;;   `(progn (defvar ,name ,(make-keymap (format nil "\"~a\"" name)))
;; 	  (define-key ,name ,body)))

;; (my-make-keymap *my-universal-keymap*
;;   "/" 'search-buffers)

(defvar *my-universal-keymap* (make-keymap "*my-universal-keymap*"))
(define-key *my-universal-keymap*
  "/" 'nyxt/web-mode:search-buffers
  "C-o" 'nyxt/web-mode:history-all-query
  "C-i" 'nyxt/web-mode:history-forwards-all-query
  "o" 'set-url-from-current-url)

(defvar *my-leader-keymap* (make-keymap "*my-leader-keymap*"))
(define-key *my-leader-keymap*
  "o" 'set-url
  "b" 'switch-buffer
  "q" 'delete-current-buffer)

(defvar *my-goto-keymap* (make-keymap "*my-goto-keymap*"))
(define-key *my-goto-keymap*
  "b" 'set-url-from-bookmark)

(defvar *my-normal-keymap* (make-keymap "*my-normal-keymap*"))
(define-key *my-normal-keymap*
  "C-o" 'nyxt/web-mode:history-backwards
  "C-i" 'nyxt/web-mode:history-forwards
  "y y" 'copy-url
  "y p" 'copy-password
  ;; Hinting
  "M-/" 'nyxt/web-mode:copy-hint-url
  "C-/" 'nyxt/web-mode:follow-hint
  "; d" 'nyxt/web-mode:download-hint-url
  "C-u" *my-universal-keymap*
  "g" *my-goto-keymap*
  "space" *my-leader-keymap*)

(defvar *my-insert-keymap* (make-keymap "*my-insert-keymap*"))
(define-key *my-insert-keymap*
  "C-[" 'nyxt/vi-mode:vi-normal-mode
  "C-w" 'nyxt/input-edit-mode:delete-backwards-word
  "C-f" 'nyxt/input-edit-mode:cursor-forwards
  "C-b" 'nyxt/input-edit-mode:cursor-backwards)

(defvar *my-minibuffer-keymap* (make-keymap "*my-minibuffer-keymap*"))
(define-key *my-minibuffer-keymap*
  "C-w" 'nyxt/minibuffer-mode:delete-backwards-word)

(define-mode my-states-mode ()
  "Mode to add custom keybindings"
  ((keymap-scheme :initform (keymap:make-scheme
                             scheme:vi-normal *my-normal-keymap*
                             scheme:emacs *my-insert-keymap*
                             scheme:vi-insert *my-insert-keymap*))))

(defvar *my-global-keymap* (make-keymap "*my-global-keymap*"))
(define-key *my-global-keymap*
  "C-d" 'quit)

(define-mode my-global-mode ()
  "Mode to add custom keybindings"
  ((keymap-scheme :initform (keymap:make-scheme
                             scheme:emacs *my-global-keymap*
                             scheme:vi-normal *my-global-keymap*
                             scheme:vi-insert *my-global-keymap*))))

(define-configuration (buffer web-buffer)
  ((default-modes
    (append '(my-global-mode my-states-mode vi-normal-mode)
            %slot-default))))
