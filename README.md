# DevOps Portfolio Project: Microservice App with Flask, Docker, and AWS

## Overview
This project demonstrates the creation, containerization, and deployment of a Python Flask microservice application. The application is deployed on an AWS EC2 instance using Docker and GitHub Container Registry (GHCR).

## Project Steps
1. **Developed a Python Flask Microservice**
   - Created a simple Flask application (`app.py`).
   
2. **Containerized the Application with Docker**
   - Built a Docker image using a `Dockerfile`.
   - Ran the container locally and tested it.

3. **Pushed the Docker Image to GitHub Container Registry (GHCR)**
   - Logged into GHCR using a GitHub Personal Access Token (PAT).
   - Tagged and pushed the Docker image to GHCR.

4. **Deployed the Application on AWS EC2**
   - Created an Ubuntu EC2 instance.
   - Installed Docker on the instance.
   - Pulled the Docker image from GHCR and ran it on the EC2 instance.
   - Accessed the application via the EC2 instance's public IP.

## Repository Structure