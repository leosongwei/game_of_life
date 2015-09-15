(load "asdf.lisp")

(defvar cl-ncurses-path
  (car (directory "./lisplibs/cl-ncurses_0.1.4/")))
(defvar uffi-path
  (car (directory "./lisplibs/uffi-20130813-git/")))
(defvar opengl-path
  (car (directory "./lisplibs/cl-opengl-20150302-git/")))
(defvar cffi-path
  (car (directory "./lisplibs/cffi_0.15.0/")))
(defvar alexandria-path
  (car (directory "./lisplibs/alexandria-20150505-git/")))
(defvar trivial-features-path
  (car (directory "./lisplibs/trivial-features-20150113-git/")))
(defvar babel-path
  (car (directory "./lisplibs/babel-20150608-git/")))

(setf asdf/find-system:*central-registry* nil)
(push cl-ncurses-path asdf/find-system:*central-registry*)
(push uffi-path asdf/find-system:*central-registry*)
(push opengl-path asdf/find-system:*central-registry*)
(push cffi-path asdf/find-system:*central-registry*)
(push alexandria-path asdf/find-system:*central-registry*)
(push trivial-features-path asdf/find-system:*central-registry*)
(push babel-path asdf/find-system:*central-registry*)

(require :cl-ncurses)
(require :cl-opengl)
(require :cl-glu)
(require :cl-glut)

(load "main.lisp")
(load "ncurses.lisp")
(load "gl.lisp")
