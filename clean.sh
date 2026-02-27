#!/bin/bash

ACTUAL_UID=$(id -u) ACTUAL_GID=$(id -g) USERNAME=$(whoami) docker compose down --remove-orphans

docker rmi devcontainer/ubuntu_24.04:latest
