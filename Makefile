PYTHON ?= python
CYTHON ?= cython
TESTS ?= pytest
CYTHONSRC=$(wildcard pyearth/*.pyx)
CSRC=$(CYTHONSRC:.pyx=.c)

inplace: cython
	$(PYTHON) setup.py build_ext -i

all: inplace

cython: $(CSRC)

clean:
	rm -f pyearth/*.c pyearth/*.so pyearth/*.pyc pyearth/test/*.pyc pyearth/test/basis/*.pyc pyearth/test/record/*.pyc

%.c: %.pyx
	$(CYTHON) $<

test: inplace
	$(TESTS) -s pyearth

test-coverage: inplace
	$(TESTS) -s --with-coverage --cover-html --cover-html-dir=coverage --cover-package=pyearth pyearth

verbose-test: inplace
	$(TESTS) -sv pyearth
