(load "asdf.lisp")

(defvar cl-ncurses-path
  (car (directory "./lisplibs/cl-ncurses_0.1.4/")))
(defvar uffi-path
  (car (directory "./lisplibs/uffi-20130813-git/")))

(setf asdf/find-system:*central-registry* nil)
(push cl-ncurses-path asdf/find-system:*central-registry*)
(push uffi-path asdf/find-system:*central-registry*)

(require :cl-ncurses)
(load "main.lisp")

(sb-ext:save-lisp-and-die
  "lifegame"
  :executable t :compression 3
  :toplevel #'game-of-life:top)
