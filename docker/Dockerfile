FROM elixir:latest

MAINTAINER Chong Zhi Wei <zweicoder@gmail.com>

RUN apt-get update && apt-get install -y git curl wget make inotify-tools sudo
RUN curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash - && sudo apt-get install -y nodejs
RUN apt-get install -y postgresql-client
RUN apt-get clean

# Add user in image so Phoenix gets installed into the correct directory (otherwise goes to root/.mix)
RUN useradd -u 9991 -ms /bin/bash docker-user
USER docker-user
WORKDIR /home/docker-user
# Install deps for Phoenix
RUN mix local.hex --force
RUN mix archive.install https://github.com/phoenixframework/archives/raw/master/phoenix_new.ez --force

USER root
# Extend this and install the database wanted e.g. PostgreSQL / MySQL

CMD ["bash"]
