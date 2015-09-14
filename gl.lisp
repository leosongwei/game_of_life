(in-package game-of-life)


(defclass game-window (glut:window)
  ()
  (:default-initargs
    :width 500 :height 500
    :mode '(:single :rgb)
    :title "life game"))

(defmethod glut:display-window
  :before ((w game-window))
  (gl:clear-color 0 0 0 0)
  (gl:matrix-mode :projection)
  (gl:load-identity)
  (glu:ortho-2d 0 500 500 0))

(defmethod glut:display ((w game-window))
  (gl:clear :color-buffer)
  ;; Draw white polygon (rectangle) with corners at
  ;; (0.25, 0.25, 0.0) and (0.75, 0.75, 0.0).
  (gl:color 0 1 0)
  (gl:with-primitive :polygon
    (%gl:vertex-2i 50 50)
    (%gl:vertex-2i 450 50)
    (%gl:vertex-2i 450 450)
    (%gl:vertex-2i 50 450))
  ;; Start processing buffered OpenGL routines.
  (gl:flush))

