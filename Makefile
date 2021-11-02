GOARCH = amd64
GOOS = darwin

GOTEST = go test


VERSION?=?
COMMIT=$(shell git rev-parse HEAD)
BRANCH=$(shell git rev-parse --abbrev-ref HEAD)

# Setup the -ldflags option for go build here, interpolate the variable values
LDFLAGS = -ldflags "-X main.VERSION=${VERSION} -X main.COMMIT=${COMMIT} -X main.BRANCH=${BRANCH}"


default: help

all: darwin linux windows

darwin: vet lint ## build darwin mqgen and mqgo binaries
	$(MAKE) GOOS=darwin bin/mqgo
	$(MAKE) GOOS=darwin bin/mqgen

linux: vet lint ## build linux mqgen and mqgo binaries
	$(MAKE) GOOS=linux bin/mqgo
	$(MAKE) GOOS=linux bin/mqgen

windows: vet lint ## build windows mqgen and mqgo binaries
	$(MAKE) GOOS=windows bin/mqgo.exe
	$(MAKE) GOOS=windows bin/mqgen.exe

# Add new modules via `go get -d github.com/org/module`
bin/%: ## build binary - optons: mqgen or mqgo
	GOOS=${GOOS} GOARCH=${GOARCH} go build ${LDFLAGS} -o bin/$(@F) ./$(basename $(@F))

install: vet lint ## install mqgen and mqgo
	GOOS=${GOOS} GOARCH=${GOARCH} go install ${LDFLAGS} ./mqgo
	GOOS=${GOOS} GOARCH=${GOARCH} go install ${LDFLAGS} ./mqgen

# go test a specific package -v github.com/meqaio/swagger_meqa/mqutil -run TestMapIsCompatible
test: ## run unit tests
	${GOTEST} -v -coverprofile=coverage.out ./...

golint: ## run lint
	golangci-lint run

clean: ## clean binary output and coverage file
	rm -Rf bin/* *.out

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":[^:]*?## "}; {printf "\033[38;5;69m%-30s\033[38;5;38m %s\033[0m\n", $$1, $$2}'
