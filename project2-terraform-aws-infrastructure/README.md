# Project 2: Terraform AWS Infrastructure

## Overview
This project demonstrates how to provision a secure and scalable AWS infrastructure using Terraform. It includes the following components:
- **VPC**: A Virtual Private Cloud for isolating resources.
- **EC2 Instances**: Virtual servers for running applications.
- **S3 Bucket**: A storage bucket for static files.
- **Security Groups**: Firewall rules for controlling traffic.

The infrastructure is defined using Terraform modules, making it modular, reusable, and easy to maintain.

---

## Table of Contents
1. [Prerequisites](#prerequisites)
2. [Project Structure](#project-structure)
3. [Setup Instructions](#setup-instructions)
4. [Terraform Configuration](#terraform-configuration)
5. [Modules](#modules)
6. [Validation and Deployment](#validation-and-deployment)
7. [Verification](#verification)
8. [Cleanup](#cleanup)
9. [Troubleshooting](#troubleshooting)

---

## Prerequisites
Before you begin, ensure you have the following:
1. **Terraform Installed**: Download and install Terraform from [here](https://www.terraform.io/downloads.html).
2. **AWS CLI Configured**: Install the AWS CLI and configure it with your credentials using:
   ```bash
   aws configure
   ```
3. Git Installed: Ensure Git is installed for version control.
4. Basic Understanding of AWS Services: Familiarity with AWS services like VPC, EC2, and S3 is recommended.

## Project Structure
The project is organized as follows:
```.
project2-terraform-aws-infrastructure/
├── main.tf              # Main Terraform configuration
├── variables.tf         # Input variables for the configuration
├── outputs.tf           # Output values after applying the configuration
├── provider.tf          # AWS provider configuration (me-south-1 region)
├── modules/             # Directory for Terraform modules
│   ├── vpc/             # VPC module
│   │   └── vpc.tf       # VPC configuration
│   ├── ec2/             # EC2 module
│   │   └── ec2.tf       # EC2 configuration
│   └── s3/              # S3 module
│       └── s3.tf        # S3 configuration
└── README.md            # Project documentation
```
## Setup Instructions
1. Clone the Repository
Clone the repository to your local machine:
   ```bash
   git clone https://github.com/anitta-antony-92/devops-portfolio-projects.git
   cd devops-portfolio-projects/project2-terraform-aws-infrastructure
   ```
2. Initialize Terraform
Initialize Terraform to download the necessary provider plugins and set up the backend:
   ```
   terraform init
   ```
This will:
- Download the AWS provider plugin.
- Set up the Terraform backend (if configured).
- Prepare the directory for Terraform execution.

3. Review and Customize Configuration:
- Modify variables.tf to customize the AWS region, instance type, or other settings.
- Ensure the S3 bucket name is unique.
## Terraform Configuration
### provider.tf
Configure the AWS provider for the me-south-1 region:

   ```
   # provider.tf
   provider "aws" {
     region = var.aws_region
   }
   ```
### main.tf
Define the main configuration, including module calls:

   ```
   # main.tf
   module "vpc" {
     source = "./modules/vpc"
   }
   
   module "ec2" {
     source    = "./modules/ec2"
     subnet_id = module.vpc.subnet_a_id  # Pass subnet_a_id to EC2 module
   }
   
   module "s3" {
     source = "./modules/s3"
   }
   ```
### variables.tf
Define input variables for the configuration:
   
   ```
   # variables.tf
   variable "aws_region" {
     type    = string
     default = "me-south-1"
   }
   ```
## Modules
### VPC Module (modules/vpc/vpc.tf)
Define the VPC configuration:

   ```
   # modules/vpc/vpc.tf
   
   # Create a VPC
   resource "aws_vpc" "main_vpc" {
     cidr_block           = "10.0.0.0/16"  # Define the IP range for the VPC
     enable_dns_support   = true           # Enable DNS support
     enable_dns_hostnames = true           # Enable DNS hostnames
     tags = {
       Name = "main-vpc"                   # Add a tag for easier identification
     }
   }
   
   # Create a Public Subnet
   resource "aws_subnet" "subnet_a" {
     vpc_id                  = aws_vpc.main_vpc.id  # Reference the VPC ID
     cidr_block              = "10.0.1.0/24"       # Define the IP range for the subnet
     availability_zone       = "me-south-1a"       # Specify the availability zone
     map_public_ip_on_launch = true                # Enable auto-assign public IP
     tags = {
       Name = "subnet-a"                          # Add a tag for easier identification
     }
   }
    
   output "subnet_a_id" {
     value = aws_subnet.subnet_a.id
   }
   ```
### EC2 Module (modules/ec2/ec2.tf)
Define the EC2 instance configuration:

   ```
   # modules/ec2/ec2.tf

   variable "subnet_id" {}
   
   # Create an EC2 Instance
   resource "aws_instance" "my-devops-terraform-ec2-project2" {
     ami           = "ami-id"  # Replace with a valid AMI for your region (e.g., Amazon Linux 2)
     instance_type = "t3.micro"               # Free Tier eligible instance type
     subnet_id     =  var.subnet_id  # Attach to the first subnet created in the VPC module
     key_name      = "my-keypair-name"          # Replace with your SSH key pair name
   
     tags = {
       Name = "my-devops-terraform-ec2-project2"             # Add a tag for easier identification
     }
   }
   
   # Output the Public IP of the EC2 Instance
   output "ec2_public_ip" {
     value = aws_instance.my-devops-terraform-ec2-project2.public_ip
   }
   ```
### S3 Module (modules/s3/s3.tf)
Define the S3 bucket configuration:

   ```
   # modules/s3/s3.tf
   
   # Create an S3 Bucket
   resource "aws_s3_bucket" "devops_terraform_bucket" {
     bucket = "my-bucket-name"  # Ensure the bucket name is globally unique
     acl    = "private"                         # Set the bucket access control to private (default)
   
     tags = {
       Name = "devops_terraform_bucket"                  # Add a tag for easier identification
     }
   }
   
   # Output the S3 Bucket Name
   output "s3_bucket_name" {
     value = aws_s3_bucket.devops_terraform_bucket.bucket
   }
   ```
## Validation and Deployment
### Validate the Configuration
- Validate the Terraform configuration for syntax errors.
- Checks for syntax errors and validates the configuration.
   ```
   terraform validate
   ```
### Preview Changes
- Preview the changes Terraform will apply:
   ```
   terraform plan
   ```
### Apply Changes
- Apply the configuration to create the AWS infrastructure:
   ```
   terraform apply
   ```
## Verification
After applying the configuration, verify the resources:
### EC2 Instance:
Check the public IP and instance ID using Terraform:
   ```
   terraform output public_ip
   ```
Or, use the AWS CLI to fetch instance details:
   ```
   aws ec2 describe-instances --query 'Reservations[*].Instances[*].[InstanceId, PublicIpAddress, State.Name]' --output table
   ```
Use the public IP to SSH into the instance using your key pair.
### S3 Bucket:
Retrieve the bucket name using Terraform:
   ```
   terraform output bucket_name
   ```
### VPC:
Check the VPC CIDR block using Terraform:
   ```
   terraform output vpc_cidr_block
   ```

Or, use the AWS CLI to describe VPCs:
   ```
   aws ec2 describe-vpcs --query 'Vpcs[*].[VpcId, CidrBlock]' --output table
   ```
## Cleanup
To avoid unnecessary costs, destroy the infrastructure after testing:
   ```
   terraform destroy
   ```
## Troubleshooting
- AWS Credentials: Ensure your AWS CLI is configured correctly.

- Region Issues: Verify that the specified region (me-south-1) supports all required services.

-  Terraform Errors: Run terraform validate to check for syntax errors.


