# CI-CD-DOCKER-GITHUB_ACTIONS-PROJECT 
 
 CI/CD Pipeline - Docker Only.

 This project demonstrates a real world CI/CD pipeline using Docker only.

 The pipeline builds, tests, containerizes, and deploys a Node.js application automatically to an AWS EC2 server using GitHub Actions.


# Tech Stack

- GitHub Actions (CI/CD)
- Docker & Docker Hub
- Node.js (Express)
- AWS EC2 (Linux)
- SSH-based deployment


 # Architecture Overview

 Developer (Git Push)

GitHub Repository

GitHub Actions (CI)

Checkout code

Install dependencies

Run tests

Build Docker image

Push image to Docker Hub

GitHub Actions (CD)

SSH into EC2

Pull latest Docker image

Stop old container

Run new container

Application Live on EC2 (Port 80)


# CI/CD Pipeline Flow

1. Code is pushed to the `main` branch
2. GitHub Actions workflow is triggered
3. Application dependencies are installed
4. Tests are executed
5. Docker image is built
6. Image is pushed to Docker Hub
7. GitHub Actions connects to EC2 via SSH
8. Old container is stopped and removed
9. New container is started with the latest image


# Repository Structure
 app/
 index.js
 package.json
 package-lock.json
 -------------------
 Dockerfile
 --------------------
 deploy.sh
 --------------------
 .github/workflows/ci-cd.yml
 -----------------------------
 README.md
 ----------

Application Endpoints

- `/` → Main application
- `/health` → Health check endpoint


# Required GitHub Secrets

These secrets are configured in the GitHub repository settings:

- DOCKERHUB_USERNAME

- DOCKERHUB_TOKEN

- EC2_HOST

- EC2_USER

- EC2_SSH_KEY


# Real Issue Faced During Deployment

# Problem
During the Deploy to EC2 step, the pipeline failed with the following error:

permission denied while trying to connect to the Docker daemon socket
/var/run/docker.sock


The CI pipeline was successful, but the CD step failed while running Docker commands on the EC2 server.


Root Cause

- Docker daemon runs as root
- The EC2 SSH user (`ec2-user`) did not have permission to access Docker
- User was **not part of the `docker` group

As a result, commands like `docker pull` and `docker run` failed.



#  Fix 

On the EC2 server:

sudo usermod -aG docker ec2-user

exit 

Then SSH back into the server to apply group changes.

After this fix, the deployment step succeeded without errors.


# Key Learnings

- CI can succeed while CD fails due to server-level issues.

- Understanding Linux users and groups is critical for DevOps.

- Debugging deployment issues is more important than just deployment.

  
