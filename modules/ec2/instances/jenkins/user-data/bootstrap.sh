#!/bin/bash
set -euo pipefail

# Log all commands and their output
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

# --- System Setup ---
echo "Updating system packages..."
sudo apt-get update -y

echo "Installing Git, Docker, and AWS CLI..."
sudo apt-get install -y git docker.io awscli

# --- Docker Configuration ---
echo "Configuring Docker..."
sudo docker network create jenkins-net

# Configure Docker log rotation
sudo mkdir -p /etc/docker
cat <<EOF | sudo tee /etc/docker/daemon.json
{
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "10m",
    "max-file": "3"
  }
}
EOF

sudo systemctl restart docker
sudo systemctl start docker
sudo systemctl enable docker

# --- User Setup ---
echo "Adding users to the Docker group..."
CURRENT_USER=$(id -un 2>/dev/null || echo "ubuntu")
sudo usermod -aG docker "$CURRENT_USER"
sudo usermod -aG docker ssm-user

# --- Jenkins Setup ---
echo "Pulling Jenkins Docker image..."
sudo docker pull jenkins/jenkins:lts

echo "Starting Jenkins container..."
sudo docker run -d \
  --name jenkins-main \
  --network jenkins-net \
  -p 8080:8080 \
  -v jenkins_home:/var/jenkins_home \
  -v /var/run/docker.sock:/var/run/docker.sock \
  --restart unless-stopped \
  -e JENKINS_OPTS="--install-plugins=docker-workflow:latest,git:latest,pipeline:latest,amazon-ecr:latest" \
  jenkins/jenkins:lts

# --- Health Check ---
echo "Waiting for Jenkins to start..."
sleep 30
if ! sudo docker ps | grep -q "jenkins-main"; then
  echo "ERROR: Jenkins container failed to start!"
  exit 1
fi
echo "Jenkins is running and accessible on port 8080!"

# --- Cleanup ---
echo "Cleaning up unused Docker resources..."
sudo docker system prune -f

echo "Bootstrap completed successfully!"