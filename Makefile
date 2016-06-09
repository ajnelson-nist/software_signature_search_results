#!/usr/bin/make -f

# This software was developed at the National Institute of Standards
# and Technology by employees of the Federal Government in the course
# of their official duties. Pursuant to title 17 Section 105 of the
# United States Code this software is not subject to copyright
# protection and is in the public domain. NIST assumes no
# responsibility whatsoever for its use by other parties, and makes
# no guarantees, expressed or implied, about its quality,
# reliability, or any other characteristic.
#
# We would appreciate acknowledgement if the software is used.

all: \
  dist

.PHONY: \
  demo \
  dist \
  extra

SUBMODULES_CHECKED_OUT.log:
	git submodule init
	git submodule update
	touch $@

demo: \
  SUBMODULES_CHECKED_OUT.log
	$(MAKE) -C deps/evaluation demo-prereqs
	$(MAKE) -C deps/evaluation demo.html
	@echo "See the file: deps/evaluation/demo.html."

dist: \
  SUBMODULES_CHECKED_OUT.log
	$(MAKE) -C deps/evaluation dist
	cd deps/evaluation ; rsync -av --progress --include-from=export_results.txt --exclude=* ./ ../../

extra: \
  dist
	$(MAKE) -C deps/evaluation extra
	cd deps/evaluation ; rsync -av --progress --include-from=export_results.txt --exclude=* ./ ../../
