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

## FAQ

#### Why not just use the Docker -u flag?
- The Mix dependencies will either have to be installed in `root/.mix` or `/home/<user>/.mix`, which causes issues unless we `chown` the directory it was installed at.
- Also, when using something like `docker run -u "$(id -u):$(id -g)"` the UID and GID will probably not be present in the container's `/etc/passwd` file. Some applications will fail to start because of this. See [this post](https://denibertovic.com/posts/handling-permissions-with-docker-volumes/)


## TODO 
- [ ] Manage postgresql setup?
- [ ] `mix ecto.create` doesn't work when trying to connect to the databse. Issue probably fixed in ecto 2.0. `psql -U postgres -h <postgres-host>` still works but in the meantime no idea how to fix this
