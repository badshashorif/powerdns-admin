#!/bin/bash
# This script updates the Docker containers defined in the docker-compose.yml file.
# It pulls the latest images and starts the containers in detached mode.
# It also removes any orphaned containers that are no longer needed.
# This is useful for keeping the containers up to date with the latest changes.
# Pull the latest images for the containers
# This ensures that the containers are using the most recent versions of the images.
# It also helps to reduce the size of the images by removing any unused layers.
docker compose pull
docker compose up -d --remove-orphans
