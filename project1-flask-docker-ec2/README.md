# DevOps Portfolio Project: Microservice App with Flask, Docker, and AWS

## Overview
This project demonstrates the creation, containerization, and deployment of a Python Flask microservice application. The application is containerized using Docker and deployed on an AWS EC2 instance. The Docker image is stored on GitHub Container Registry (GHCR).

## Project Steps
1. **Developed a Python Flask Microservice**
   - Created a simple Flask application (`app.py`).
   
2. **Containerized the Application with Docker**
   - Built a Docker image using a `Dockerfile`.
   - Ran the container locally and tested the application.

3. **Pushed the Docker Image to GitHub Container Registry (GHCR)**
   - Logged into GHCR using a GitHub Personal Access Token (PAT).
   - Tagged and pushed the Docker image to GHCR.

4. **Deployed the Application on AWS EC2**
   - Created an Ubuntu EC2 instance.
   - Installed Docker on the instance.
   - Pulled the Docker image from GHCR and ran it on the EC2 instance.
   - Accessed the application via the EC2 instance's public IP.

## Repository Structure
```.
.
├── app.py                 # Python Flask application
├── Dockerfile             # Dockerfile for containerizing the app
├── README.md              # Project documentation
├── docker/                # Docker-related files and configurations
│   ├── .dockerignore      # Dockerignore file
│   └── Dockerfile         # Dockerfile for containerizing the app
├── github-actions/        # GitHub Actions for CI/CD
│   ├── ci.yml             # Continuous Integration configuration
│   └── cd.yml             # Continuous Deployment configuration
└── src/                   # Application source code and files
    └── app.py             # Flask app entry point
```
## Setup Instructions

### Prerequisites
- Docker installed on your local machine.
- A GitHub account with a Personal Access Token (PAT) for GHCR.
- An AWS account with an EC2 instance set up.

### Steps to Run the Project
1. **Clone this repository to your local machine:**
   ```bash
   git clone https://github.com/anitta-antony-92/devops-portfolio-projects.git
2. **Navigate to the project folder:**
   ```bash
   cd devops-portfolio-projects/project1-flask-docker-ec2
3. **Build the Docker image:**
   ```bash
   docker build -t flask-docker-app .
4. **Run the Docker container locally:**
   ```bash
   docker run -p 5000:5000 flask-docker-app
5. **Deploy to AWS EC2**
   - SSH into your EC2 instance.
   - Install Docker if not already installed.
   - Pull the Docker image from GHCR:
     ```bash
     docker pull ghcr.io/your-username/flask-docker-app:latest
     ```
   - Run the Docker container on the EC2 instance:
     ```bash
     docker run -d -p 5000:5000 ghcr.io/your-username/flask-docker-app:latest
     ```
   - Access the application via the EC2 instance's public IP (e.g., `http://<EC2-Public-IP>:5000`).

## Conclusion
This project demonstrates a complete DevOps workflow by building, containerizing, and deploying a Flask application using Docker and AWS EC2. It also highlights the use of GitHub Container Registry (GHCR) for storing Docker images.

