(in-package game-of-life)

(defun put-dark (r c)
  (attroff a_reverse)
  (mvaddch r c (char-code #\Space)))

(defun put-bright (r c)
  (attron a_reverse)
  (mvaddch r c (char-code #\Space)))

(defun display-by-ncurses ()
  (dotimes (r *height*)
    (dotimes (c *width*)
      (let ((cell (aref (car *array-cons*) r c)))
        (if (= 1 cell)
          (put-bright r c)
          (put-dark r c)))))
  (refresh))

(defun ncurses-top ()
  (init-display)
  (init-game)
  (sb-thread:make-thread #'keystroke)
  (loop
    (sleep 0.1)
    (calculate-frame)
    (display-by-ncurses)))
