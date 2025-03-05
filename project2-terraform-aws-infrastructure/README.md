# Project 2: Terraform AWS Infrastructure

## Overview
This project sets up a basic AWS infrastructure using Terraform. It includes the following components:
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
8. [Contributing](#contributing)
9. [License](#license)

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

##Setup Instructions
1. Clone the Repository
Clone the repository to your local machine:
git clone https://github.com/anitta-antony-92/devops-portfolio-projects.git
cd devops-portfolio-projects/project2-terraform-aws-infrastructure
2. Initialize Terraform
Initialize Terraform to download the necessary provider plugins and set up the backend:
```
terraform init
```
This will:

Download the AWS provider plugin.

Set up the Terraform backend (if configured).

Prepare the directory for Terraform execution.

3. Create Terraform Configuration Files
Create the necessary Terraform files:
```
touch main.tf variables.tf outputs.tf provider.tf
```
4. Create Modules Directory
Create a directory structure for Terraform modules:
```
mkdir -p modules/vpc modules/ec2 modules/s3
touch modules/vpc/vpc.tf modules/ec2/ec2.tf modules/s3/s3.tf
```
##Terraform Configuration
provider.tf
Configure the AWS provider for the me-south-1 region:

```
provider "aws" {
  region = "me-south-1"
}
```
main.tf
Define the main configuration, including module calls:

```
module "vpc" {
  source = "./modules/vpc"
  # Add VPC-specific variables here
}

module "ec2" {
  source = "./modules/ec2"
  # Add EC2-specific variables here
}

module "s3" {
  source = "./modules/s3"
  # Add S3-specific variables here
}
```
variables.tf
Define input variables for the configuration:

```
variable "instance_type" {
  description = "EC2 instance type"
  default     = "t3.micro"
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  default     = "ami-0a95ef992b0368b4c"
}
```
outputs.tf
Define output values:

```
output "public_ip" {
  description = "Public IP of the EC2 instance"
  value       = module.ec2.public_ip
}

output "bucket_name" {
  description = "Name of the S3 bucket"
  value       = module.s3.bucket_name
}
```
##Modules
VPC Module (modules/vpc/vpc.tf)
Define the VPC configuration:

```
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "my-devops-vpc"
  }
}
```
EC2 Module (modules/ec2/ec2.tf)
Define the EC2 instance configuration:

```
resource "aws_instance" "my-devops-terraform-ec2-project2" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.main.id
  tags = {
    Name = "my-devops-terraform-ec2-project2"
  }
}
```
S3 Module (modules/s3/s3.tf)
Define the S3 bucket configuration:

```
resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-devops-terraform-s3-bucket"
  acl    = "private"
}
```
##Validation and Deployment
###Validate the Configuration
Validate the Terraform configuration for syntax errors:
```
terraform validate
```
Preview Changes
Preview the changes Terraform will apply:
```
terraform plan
```
Apply Changes
Apply the configuration to create the AWS infrastructure:
```
terraform apply
```
###Verification
After applying the configuration, verify the resources:

EC2 Instance:

Public IP: 15.185.142.134

Instance ID: i-07833d3d4f4b3779d

State: Running

S3 Bucket:

Bucket Name: my-devops-terraform-s3-bucket

VPC:

CIDR Block: 10.0.0.0/16

Contributing
Contributions are welcome! Please follow these steps:

Fork the repository.

Create a new branch for your feature or bugfix.

Submit a pull request with a detailed description of your changes.

