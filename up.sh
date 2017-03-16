#!/bin/bash
# chown the mounted directory in the docker container
set -e

DOCKER_IMAGE="zweicoder/phoenix-docker"
COMMAND="bash"

DOCKER_USER="docker"
DOCKER_GROUP="docker-group"

# in this particular case this must be /home/docker-user as phoenix was installed there
HOME_DIR="/home/docker-user"
WORK_DIR="$HOME_DIR/$(basename $PWD)"

PARAMS="$PARAMS -it --rm"
PARAMS="$PARAMS -v $PWD:$WORK_DIR"
PARAMS="$PARAMS -w $WORK_DIR"
PARAMS="$PARAMS --link some-postgres:postgres"

USER_ID=$(id -u)
GROUP_ID=$(id -g)

# basically we create another user and steal the home directory from the original `docker-user`
run_docker()
{
  echo \
    groupadd -f -g $GROUP_ID $DOCKER_GROUP '&&' \
    useradd -u $USER_ID -g $DOCKER_GROUP $DOCKER_USER '&&' \
    chown -R $DOCKER_USER:$DOCKER_GROUP $HOME_DIR '&&' \
    sudo -u $DOCKER_USER HOME=$HOME_DIR $COMMAND
}
# todo somehow use compose?
# docker run --name some-postgres -d postgres
if [ -z "$DOCKER_HOST" ]; then
    docker run $PARAMS $DOCKER_IMAGE /bin/bash -c "$(run_docker) $*"
else
    docker run $PARAMS $DOCKER_IMAGE $COMMAND "$*"
fi
