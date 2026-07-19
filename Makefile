.PHONY: build run

build:
	./scripts/build.sh

run:
	./scripts/run-qemu.sh

setup:
	git submodule update --init --recursive
	docker build --tag folune-builder:dev docker
