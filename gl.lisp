(in-package game-of-life)


(defclass game-window (glut:window)
  ()
  (:default-initargs
    :width 500 :height 500
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
  (glu:ortho-2d 0 500 500 0))

(defun draw-square (r c)
  (let ((len 3)
        (left (* 4 c))
        (top (* 4 r)))
    (gl:with-primitive :polygon
      (%gl:vertex-2i left top)
      (%gl:vertex-2i (+ left len) top)
      (%gl:vertex-2i (+ left len) (+ top len))
      (%gl:vertex-2i left (+ top len)))))

(defun gl-top ()
  (let ((*screen-width* 125)
        (*screen-height* 125))
    (init-game))

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

