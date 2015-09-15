(load "load.lisp")

(in-package game-of-life)
;;;; -------------- Config here ---------------------
(setf top-func #'ncurses-top)
;;;; ------------------------------------------------
(in-package cl)

(sb-ext:save-lisp-and-die
  "lifegame"
  :executable t :compression 3
  :toplevel #'game-of-life:top)
