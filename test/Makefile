include ../utils/Makefile.help
include ../utils/Makefile.functions

NAME := exim-smtp
ROOT_DIR:=$(shell realpath root)

test: setup ##@targets Starts docker compose.
	export ROOT_DIR="$(ROOT_DIR)" \
	&& docker-compose -p ${NAME} -f test.yaml up
.PHONY: test

rm:
	export ROOT_DIR="$(ROOT_DIR)" \
	&& docker-compose -p ${NAME} -f test.yaml stop

clean: rm
	export ROOT_DIR="$(ROOT_DIR)" \
	&& docker-compose -p ${NAME} -f test.yaml rm

setup:
	mkdir -p $(ROOT_DIR)
	sudo chown 104:108 -R $(ROOT_DIR)
.PHONY: setup
