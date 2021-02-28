(in-package #:cl-user)

(asdf:load-system :clim-color-picker)

(sb-ext:disable-debugger)

(sb-ext:save-lisp-and-die "color-picker"
                          :toplevel (find-symbol "%MAIN" "CLIM-COLOR-PICKER")
                          :executable t)
