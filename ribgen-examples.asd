;;;; rib-examples.asd

(asdf:defsystem #:ribgen-examples
  :serial t
  :description "Renderman examples"
  :author "Jeremiah LaRocco <jeremiah_larocco@fastmail.com>"
  :license "ISC"
  :depends-on (#:ribgen)
  :components ((:module "examples"
                        :components
                        ((:file "package")
                         (:file "sphere")))))

