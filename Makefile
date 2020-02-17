install:
	bash winit helm
test:
	bash test/test_all.sh

all: install test

.PHONY: install test all
