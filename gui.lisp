(defpackage #:clim-color-picker
  (:use #:clim #:clim-lisp))

(in-package #:clim-color-picker)

(define-application-frame color-picker ()
  ()
  (:menu-bar nil)
  (:panes
   (display :application
            :scroll-bars nil
            :display-function 'display-color)
   (exit push-button
         :label "Exit"
         :activate-callback (lambda (button)
                              (frame-exit (pane-frame button))))
   (red slider
        :label "Red" :foreground +red+
        :orientation :horizontal
        :value 0.2
        :min-value 0.0 :max-value 1.0
        :show-value-p t :decimal-places 3
        :client 'color :id 'red)
   (green slider
          :label "Green" :foreground +green+
          :orientation :horizontal
          :value 0.4
          :min-value 0.0 :max-value 1.0
          :show-value-p t :decimal-places 3
          :client 'color :id 'green)
   (blue slider
         :label "Blue" :foreground +blue+
         :orientation :horizontal
         :value 0.6
         :min-value 0.0 :max-value 1.0
         :show-value-p t :decimal-places 3
         :client 'color :id 'blue))
  (:layouts
   (default
    (vertically ()
      (1/3
       (horizontally ()
         (1/2 display)
         (1/2 exit)))
      (2/3
       (vertically ()
         red
         green
         blue))))))

(defun frame-color (frame)
  (make-rgb-color (gadget-value (find-pane-named frame 'red))
                  (gadget-value (find-pane-named frame 'green))
                  (gadget-value (find-pane-named frame 'blue))))

(defun display-color (frame pane)
  (with-bounding-rectangle* (left top right bottom) pane
    (draw-rectangle* pane left top right bottom :ink (frame-color frame))))

(defmethod value-changed-callback :after ((slider slider) (client (eql 'color)) id value)
  (declare (ignore id value))
  (redisplay-frame-pane (pane-frame slider) 'display))

(defun %main ()
  (run-frame-top-level (make-application-frame 'color-picker)))
