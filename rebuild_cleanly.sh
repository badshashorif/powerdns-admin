#!/bin/bash
# This script is used to rebuild the Docker containers for the project.
# It stops and removes the existing containers, volumes, and networks,
# and then builds and starts the containers again.
# Stop and remove existing containers, volumes, and networks
# This is useful for cleaning up any stale data or configurations.
# It ensures that the containers are rebuilt from scratch.
# It also removes any orphaned containers that are no longer needed.
docker-compose down -v
docker-compose up -d --build
