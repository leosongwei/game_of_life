(defpackage game-of-life
  (:use cl cl-user cl-ncurses)
  (:export :top))

(in-package game-of-life)

(defvar *width* 0)
(defvar *height* 0)
(defvar *screen-width* 0)
(defvar *screen-height* 0)

(defvar *array-cons* nil)

(defun init-display ()
  (initscr)
  (raw)
  (noecho)
  (curs-set 0)
  (clear)
  (refresh)
  (getmaxyx *stdscr*
            *screen-height*
            *screen-width*))

(defun init-random (rate)
  "rate is a number between 0-10."
  (let ((h (array-dimension (car *array-cons*) 0))
        (w (array-dimension (car *array-cons*) 1)))
    (dotimes (hi h)
      (dotimes (wi w)
        (if (< (random 10) rate)
          (setf (aref (car *array-cons*) hi wi) 1)
          (setf (aref (car *array-cons*) hi wi) 0))))))

(defun init-game ()
  (setf *width* *screen-width*)
  (setf *height* *screen-height*)

  (setf *array-cons*
        (cons (make-array (list *height* *width*))
              (make-array (list *height* *width*))))
  (init-random 3)
  t)

(defun access-cell-square (r c)
  (let ((y (mod r *height*))
        (x (mod c *width*)))
    (if (or (>= r *height*)
            (>= c *width*)
            (< r 0)
            (< c 0))
      0
      (aref (car *array-cons*) y x))))

(defun access-cell-loop (r c)
  (let ((y (mod r *height*))
        (x (mod c *width*)))
    (aref (car *array-cons*) y x)))

(defun access-cell (r c)
  (let ((way #'access-cell-loop))
    (funcall way r c)))

(defun calculate-cell (r c)
  (+ (access-cell (- r 1) (- c 1))
     (access-cell (- r 1) (- c 0))
     (access-cell (- r 1) (+ c 1))

     (access-cell (- r 0) (- c 1))
     (access-cell (- r 0) (+ c 1))

     (access-cell (+ r 1) (- c 1))
     (access-cell (+ r 1) (- c 0))
     (access-cell (+ r 1) (+ c 1))))

(defun between= (a x b)
  (and (<= a x)
       (<= x b)))

(defun calculate-frame ()
  (let ((a (car *array-cons*))
        (d (cdr *array-cons*))
        (h *height*)
        (w *width*))
    (dotimes (r h)
      (dotimes (c w)
        (let ((cell (aref a r c)))
          (if (= 1 cell)
            (setf (aref d r c)
                  (if (between=
                        2 (calculate-cell r c) 3)
                    1 0))
            (setf (aref d r c)
                  (if (= 3 (calculate-cell r c))
                    1 0))))))
    (setf (car *array-cons*) d)
    (setf (cdr *array-cons*) a)))

(defun keystroke ()
  (loop
    (let ((key (code-char (getch))))
      (cond ((eq key #\q)
             (progn
               (clear)
               (endwin)
               (sb-ext:exit)))
            ((eq key #\r)
             (init-game))))))

(defvar display-func (lambda () nil))
(defun display-car ()
  (funcall display-func))

(defun top ()
  (init-display)
  (init-game)
  (sb-thread:make-thread #'keystroke)
  (loop
    (sleep 0.1)
    (calculate-frame)
    (display-car)))
