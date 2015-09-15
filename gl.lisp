(in-package game-of-life)

(defclass game-window (glut:window)
  ()
  (:default-initargs
    :width 800 :height 400
    :title "life game"))

(defmethod glut:tick ((w game-window))
  (calculate-frame)
  (glut:post-redisplay))

(defmethod glut:display-window
  :before ((w game-window))
  (glut:enable-tick w 100)
  (gl:clear-color 0 0 0 0)
  (gl:shade-model :smooth)
  (gl:matrix-mode :projection)
  (gl:load-identity)
  (glu:ortho-2d 0 800 400 0))

(defun draw-square (r c)
  (let* ((len 4)
         (left (* (1+ len) c))
         (top (* (1+ len) r)))
    (gl:with-primitive :polygon
      (%gl:vertex-2i left top)
      (%gl:vertex-2i (+ left len) top)
      (%gl:vertex-2i (+ left len) (+ top len))
      (%gl:vertex-2i left (+ top len)))))

(defmethod glut:display ((w game-window))
  (gl:clear :color-buffer)
  (gl:color 0 1 0)
  (dotimes (r *height*)
    (dotimes (c *width*)
      (let ((cell (aref (car *array-cons*) r c)))
        (if (= 1 cell)
          (draw-square r c)
          nil))))
  (glut:swap-buffers))

(defun gl-top ()
  (let ((*screen-width* 160)
        (*screen-height* 80))
    (init-game))
  (glut:display-window
    (make-instance 'game-window)))
