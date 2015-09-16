(in-package game-of-life)

(defparameter *screen-width-pixel* 800)
(defparameter *screen-height-pixel* 450)
(defparameter *cell-len* 5)

(defun init-game-sdl ()
  (let ((*screen-width* (/ *screen-width-pixel*
                           *cell-len*))
        (*screen-height* (/ *screen-height-pixel*
                            *cell-len*)))
    (init-game)))

(defun renderer-clear (renderer)
  (progn (set-render-draw-color renderer 0 0 0 255)
         (render-clear renderer)))

(defun draw-square (renderer x y len)
  (set-render-draw-color renderer 0 255 0 255)
  (render-fill-rect renderer
                    (make-rect x y len len)))

(defun draw-all-square (renderer)
  (with-mutex (*mutex-car*)
    (dotimes (r *height*)
      (dotimes (c *width*)
        (let ((cell (aref (car *array-cons*) r c)))
          (if (= 1 cell)
            (draw-square renderer
                         (* c *cell-len*)
                         (* r *cell-len*)
                         (- *cell-len* 1))))))))

(defun start-sdl-win ()
  (with-init
    (:everything)
    (with-window
      (win :title "Game of life"
           :w *screen-width-pixel* :h *screen-height-pixel*
;           :flags '(:shown :resizable :opengl))
           :flags '(:shown))
      (with-renderer
        (renderer win :flags '(:accelerated))
        (with-event-loop
          (:method :poll)
          (:keyup
            (:keysym keysym)
            (when (scancode= (sdl2:scancode-value keysym)
                             :scancode-escape)
              (push-event :quit)))
          (:idle
            ()
            (sleep 0.1)
            (calculate-frame)
            (renderer-clear renderer)
            (draw-all-square renderer)
            (render-present renderer))
          (:quit () t))))))

(defun sdl-top ()
  (init-game-sdl)
  (start-sdl-win)
  (sb-ext:exit))
