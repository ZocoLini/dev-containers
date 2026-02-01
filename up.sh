#!/bin/bash

ACTUAL_UID=$(id -u) ACTUAL_GID=$(id -g) USERNAME=$(whoami) docker compose up -d
