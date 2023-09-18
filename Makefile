.PHONY: build

BIN := demo.bin

build:
	CGO_ENABLED=0 go build -o ${BIN} -ldflags="-X 'main.version=${VERSION}'"

run:
	./${BIN}
