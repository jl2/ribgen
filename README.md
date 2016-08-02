This is a small library for generating RenderMan byte stream files tha can be rendered with compatible renderers, such as Pixar's RenderMan and 3Delight.

```commonlisp
    * (ql:quickload :ribgen)
    To load "ribgen":
      Load 1 ASDF system:
        ribgen
    ; Loading "ribgen"
    ..................................................
    [package ribgen]..
    (RIBGEN)
    * (with-open-file (str "~/rib_tests/first.rib" :direction :output :if-does-not-exist :create :if-exists :overwrite)
      (ribgen:display str "first.tif" "framebuffer" "rgba")
      (ribgen:rformat str 400 400 1.0)
      (ribgen:perspective str 1.0)
      (ribgen:translate str 0 0 200)
      (ribgen:rotate str -90 1 0 0)
      (ribgen:world-begin str)
      (ribgen:light-source str "distantlight" 1 "\"intensity\" 1.0 \"from\" [50 50  50] \"to\" [0 0 0]")
      (ribgen:light-source str "distantlight" 2 "\"intensity\" 0.4 \"from\" [-20 20  -20] \"to\" [0 0 0]")
      (ribgen:light-source str "ambientlight" 3 "\"intensity\" 0.5")
      (ribgen:scale str 0.3 0.3 0.3)
      (ribgen:surface str "plastic" "\"Ka\" [0.0] \"Kd\" [0.5] \"Ks\" [0.5] \"roughness\" [0.1]")
      (ribgen:attribute-begin str)
      (ribgen:color str 1 1 1)
      (ribgen:scale str 2 2 2)
      (ribgen:rotate str 180 1 0 0)
      (ribgen:sphere str 2 -2 2 360)
      (ribgen:attribute-end str)
      (ribgen:world-end str))
```
