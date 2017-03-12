# Phoenix Docker

Docker environment to quickly setup an environment with Phoenix and Elixir installed properly.

Due to how Mix dependencies are installed, a `docker-user` is created when building the Docker image. `up.sh` then `chown`s the directory with another user (inheriting the same UID and GID as the current user). This prevents permission issues when mounting the volume.

## Usage
`docker pull zweicoder/phoenix-docker`

copy/download `up.sh` to your project directory and `chmod u+x up.sh`

Running `up.sh` mounts the current directory and opens an interactive console to the Docker container