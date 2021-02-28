.PHONY: clean deps build

color-picker: deps build

deps:
	sbcl --noinform --eval '(ql:quickload :clim-color-picker)' --quit

build:
	sbcl --noinform --load 'BUILD.lisp' --quit

clean:
	rm -f color-picker
