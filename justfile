# Default: display available recipes
_help:
    @just --list

# Publish preview images with `<version>-preview` tag
release-preview version:
    ./build preview {{version}}

# Build local test images (`localhost/<name>/test`)
test-build:
    ./build test

# Start local containers for testing
test-start:
    mkdir -p test/pryv/mongodb/backup
    mkdir -p test/pryv/mongodb/log
    mkdir -p test/pryv/mongodb/data
    docker-compose -f test/pryv.yml up
