(load "load.lisp")

(sb-ext:save-lisp-and-die
  "lifegame"
  :executable t :compression 3
  :toplevel #'game-of-life:top)
