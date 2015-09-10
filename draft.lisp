(init-display)

(list *screen-height*
      *screen-width*
      *height*
      *width*)

(make-array '(2 4))
(init-game)
*array-cons*
(init-random 1)

(aref (make-array '(2 4)) 0 1)

(< (random 10) 3)

(init-random 1)
(car *array-cons*)
(display-car)

(init-display)
(init-game)
(progn
  (setf *array-cons*
        (cons (make-array (list *height* *width*))
              (make-array (list *height* *width*))))
  nil)
(setf run
      (sb-thread:make-thread
        (lambda ()
          (loop
            (sleep 0.05)
            (calculate-frame)
            (display-car)))))
(sb-thread:terminate-thread run)

(let ((a (car *array-cons*)))
  (setf (aref a 21 80) 1)
  (setf (aref a 22 80) 1)
  (setf (aref a 23 80) 1))

