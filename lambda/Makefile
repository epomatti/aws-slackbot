.PHONY: build

build:
	sam build

# https://www.gaunt.dev/blog/2022/glibc-error-with-aws-sam-and-go/
build-StopFunction:
	GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build -C functions/stop -o stop stop.go
	mv functions/stop/stop $(ARTIFACTS_DIR)

build-StartFunction:
	GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build -C functions/start -o start start.go
	mv functions/start/start $(ARTIFACTS_DIR)