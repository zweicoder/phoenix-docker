# Phoenix Docker

Docker environment to quickly setup an environment with Phoenix and Elixir installed properly.

Due to how Mix dependencies are installed, a `docker-user` is created when building the Docker image. `up.sh` then `chown`s the directory with another user (inheriting the same UID and GID as the current user). This prevents permission issues when mounting the volume.

## Usage
```bash
# Pull the Docker image
docker pull zweicoder/phoenix-docker

# Copy / Download up.sh to your project directory
# Make sure the file is executable
chmod u+x up.sh

# Mount current directory into Docker container
./up.sh

# Run mix / phoenix commands as per normal
mix phoenix.new hello_phoenix
```
