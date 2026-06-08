.PHONY: help test lint

# default target
help:
	@echo "Available targets:"
	@echo "  test - run all tests with race detector and coverage"
	@echo "  lint - run golangci-lint"
	@echo "  help - show this help message"

# run tests
test:
	@echo "Running tests..."
	go test -race -coverprofile=coverage.out ./...

# run linter
lint:
	@echo "Running linter..."
	golangci-lint run
