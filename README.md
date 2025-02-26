# Pryv.io release packaging

Base Docker images used for packaging Pryv.io components.

Run `./build` to build an publish image

## Todo 

Previous publishing was done one Azure... now that Pryv.io is fully open source, the archives workflow `archives/publish.yaml` should be updated for DockerHub

## Local usage

Prerequisites:
- Docker
- [just](https://github.com/casey/just#installation)

Then:
- `just release-preview <version>` to publish preview images with `<version>-preview` tag
- `just test-build` to build local test images
- `just test-start` to start local containers

See `justfile` for the details.

### Note

To launch a container (here `mongodb`) interactively: `docker run -it localhost/pryvio/mongodb:test bash`


## CHANGELOG

### 2023-05
- Use Ubuntu (22.04) instead of Phusion base image
- Add local usage: preview and test
