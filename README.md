# Pryv.io release packaging

Base Docker images used for packaging Pryv.io components.

See the [GitHub workflow](.github/workflows/publish.yaml) for how it works.

## May 2023 -- Adding "test" build capabilities

run `./build.sh test` to produce local images `localhost/{name}/test` 
launch `test/start.sh` to start local containers

## Note
Launch a container interactively: `docker run -it localhost/pryvio/mongodb:test bash`


## CHANGELOG
- May 2023 - switching to unbuntu:22:04 base image