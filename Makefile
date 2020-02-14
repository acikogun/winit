install:
./winit -a

test:
test/test_all.sh

all: install test

.PHONY: install test all
