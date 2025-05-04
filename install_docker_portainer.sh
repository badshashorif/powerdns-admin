#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

echo "🛠️ Starting Docker & Portainer Installation..."

# Update package list
apt update -y

# Install curl
echo "📦 Installing curl..."
apt install curl -y

# Install Docker using official script
echo "🐳 Installing Docker..."
curl -sSL https://get.docker.com/ | sh

# Enable and check Docker service
echo "🔧 Enabling Docker service..."
systemctl enable docker
systemctl start docker
systemctl status docker.service

# Install docker-compose
echo "📦 Installing docker-compose..."
apt install docker-compose -y

# Create data directory
echo "📁 Creating /data directory..."
mkdir -p /data
cd /data

# Create Docker volume for Portainer
echo "📦 Creating docker volume for portainer..."
docker volume create portainer_data

# Run Portainer container
echo "🚀 Launching Portainer container..."
docker run -d \
  -p 8000:8000 \
  -p 9443:9443 \
  --name portainer \
  --restart=always \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v portainer_data:/data \
  portainer/portainer-ce:latest

# Install Git
echo "📦 Installing git..."
apt install git -y

echo "✅ Installation and setup completed successfully!"