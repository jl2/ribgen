;;;; package.lisp
;;;;
;;;; Copyright (c) 2016 Jeremiah LaRocco <jeremiah.larocco@gmail.com>

(defpackage #:ribgen
  (:use #:cl)
  (:export 
   :rdeclare
   :ri-format
   :begin
   :end
   :world-begin
   :world-end
   :transform-begin
   :transform-end
   :attribute-begin
   :attribute-end
   :object-begin
   :object-end
   :object-instance
   :solid-begin
   :solid-end
   :translate
   :rotate
   :scale
   :skew
   :clipping
   :depth-of-field
   :display
   :exposure
   :frame-aspect-ratio
   :frame-begin
   :frame-end
   :motion-begin
   :motion-end
   :perspective
   :projection
   :shutter
   :area-light-source
   :atmosphere
   :color
   :light-source
   :make-cube-face-environment
   :make-lat-long-environment
   :make-shadow
   :make-texture
   :opacity
   :shading-interpolation
   :shading-rate
   :surface
   :texture-coordinates
   :option
   :cone
   :cylinder
   :disk
   :hyperboloid
   :paraboloid
   :sphere
   :torus
   :general-polygon
   :points-general-polygons
   :points-polygons
   :polygon))
