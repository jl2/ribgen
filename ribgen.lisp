;;;; ribgen.lisp
;;;;
;;;; Copyright (c) 2016 Jeremiah LaRocco <jeremiah.larocco@gmail.com>

(in-package #:ribgen)

(eval-when (:compile-toplevel :load-toplevel :execute)
  (defun variable-to-format-string (var)
    (let ((the-atom (cadr var)))
      (cond ((eq the-atom :string) "~s")
            ((eq the-atom :float) "~f")
            ((eq the-atom :int) "~d")
            ((eq the-atom :params) "~a")
            ((eq the-atom :float-list) "[~{~f~^ ~}]")
            ((eq the-atom :int-list) "[~{~d~^ ~}]")
            (t "~a"))))

  (defun symbol-to-variable-name (symb)
    (concatenate 'string (loop for val across (string-downcase (symbol-name symb))
                            for was-dash = t then last-dash
                            and last-dash = (char= val #\-)
                            when (alphanumericp val)
                            collect (if was-dash (char-upcase val) val))))

  (defmacro rman-function (name &rest params)
    (let* ((variable-names (mapcar #'car params))
           (variable-types (mapcar #'variable-to-format-string params))
           (format-string (format nil "~a ~{~a~^ ~}~~%" (symbol-to-variable-name name) variable-types))
           (all-variables (concatenate 'list (list 'stream) variable-names)))
      (when (eq 'parameters (car (last variable-names)))
        (setf (car (last all-variables)) '&optional)
        (setf all-variables (concatenate 'list all-variables '((parameters "")))))
      `(defun ,name ( ,@all-variables )
         (format stream ,format-string ,@variable-names))))

  (defmacro rman-named-function (name rname &rest params)
    (let* ((variable-names (mapcar #'car params))
           (variable-types (mapcar #'variable-to-format-string params))
           (format-string (format nil "~a ~{~a~^ ~}~~%" rname variable-types))
           (all-variables (concatenate 'list (list 'stream) variable-names)))
      (when (eq 'parameters (car (last variable-names)))
        (setf (car (last all-variables)) '&optional)
        (setf all-variables (concatenate 'list all-variables '((parameters "")))))
      `(defun ,name ( ,@all-variables )
           (format stream ,format-string ,@variable-names))))

  (rman-named-function rdeclare "Declare" (name :string) (declaration :string))

  (rman-named-function rformat "Format" (x-resolution :int) (y-resolution :int) (pixel-aspect-ratio :float))

  (rman-function begin (fname :string))

  (rman-function end)
  (rman-function world-begin)
  (rman-function world-end)
  (rman-function transform-begin)
  (rman-function transform-end)
  (rman-function attribute-begin)
  (rman-function attribute-end)
  (rman-function object-begin (num :int))
  (rman-function object-end)
  (rman-function object-instance (num :int))
  (rman-function solid-begin (operation :string))
  (rman-function solid-end)
  (rman-function translate (dx :float) (dy :float) (dz :float))
  (rman-function rotate (angle :float) (dx :float) (dy :float) (dz :float))
  (rman-function scale (sx :float) (sy :float) (sz :float))
  (rman-function skew (angle :float) (dx1 :float) (dy1 :float) (dz1 :float)
                 (dx2 :float) (dy2 :float) (dz2 :float))
  (rman-function clipping (near :float) (far :float))
  (rman-function depth-of-field (f-stop :float) (focal-length :float) (focal-distance :float))
  (rman-function display (name :string) (type :string) (mode :string) (parameters :parameters))
  (rman-function exposure (gain :float) (gamma :float))
  ;;(rman-function format (x-resolution :int) (y-resolution :int) (pixel-aspect-ratio :float))

  (rman-function frame-aspect-ratio (ratio :float))
  (rman-function frame-begin (num :int))
  (rman-function frame-end)
  (rman-function motion-begin (times :float-list))
  (rman-function motion-end)
  (rman-function perspective (fov :float))
  (rman-function projection (name :string) (parameters :parameters))
  (rman-function shutter (open-time :float) (close-time :float))
  (rman-function area-light-source (name :string) (num :int) (parameters :parameters))
  (rman-function atmosphere (name :string) (parameters :parameters))
  (rman-function color (red :float) (green :float) (blue :float))
  (rman-function light-source (name :string) (num :int) (parameters :parameters))
  (rman-function make-cube-face-environment
                 (px :string) (nx :string)
                 (py :string) (ny :string)
                 (pz :string) (nz :string)
                 (texture-name :string)
                 (fov :float) (filter :string)
                 (s-width :float) (t-width :float)
                 (parameters :parameters))
  (rman-function make-lat-long-environment
                 (picture-name :string)
                 (texture-name :string)
                 (filter :string)
                 (s-width :float)
                 (t-width :float)
                 (parameters :parameterss))
  (rman-function make-shadow 
                 (picture-name :string)
                 (texture-name :string)
                 (s-wrap :float)
                 (t-wrap :float)
                 (filter :string)
                 (s-width :float)
                 (t-width :float))
  (rman-function make-texture
                 (picture-name :string)
                 (texture-name :string)
                 (s-wrap :string) (t-wrap :string)
                 (filter :string)
                 (s-width :float) (t-width :float))

  (rman-function opacity (red :float) (green :float) (blue :float))
  (rman-function shading-interpolation (type :string))
  (rman-function shading-rate (size :int))
  (rman-function surface (name :string) (parameters :parameterss))
  (rman-function texture-coordinates
                 (s1 :float) (t1 :float)
                 (s2 :float) (t2 :float)
                 (s3 :float) (t3 :float)
                 (s4 :float) (t4 :float))
  (rman-function option (name :string) (parameters :parameterss))


  (rman-function cone (height :float) (radius :float) (thetamax :float) (parameters :parameterss))
  (rman-function cylinder (radius :float) (z-min :float) (z-max :float) (theta-max :float) (parameters :parameterss))
  (rman-function disk (height :float) (radius :float) (theta-max :float) (parameters :parameterss))
  (rman-function hyperboloid
                 (x1 :float) (y1 :float) (z1 :float)
                 (x2 :float) (y2 :float) (z2 :float)
                 (theta-max :float) (parameters :parameterss))
  (rman-function paraboloid (r-max :float) (z-min :float) (z-max :float) (theta-max :float) (parameters :parameterss))
  (rman-function sphere (radius :float) (z-min :float) (z-max :float) (theta-max :float) (parameters :parameterss))

  (rman-function torus (r-major :float) (r-min :float) (phi-min :float) (phi-max :float) (theta-max :float) (parameters :parameterss))

  (rman-function general-polygon (n-loops :int) (n-vertices :int) (parameters :parameterss))

  (rman-function points-general-polygons (num-loops :int) (num-vertices :int) (list-vertices :int-list) (parameters :parameterss))
  (rman-function points-polygons (num-vertices :int) (list-vertices :int-list) (parameters :parameterss))
  (rman-function polygon (list-vertices :int-list) (parameters :parameterss)))

