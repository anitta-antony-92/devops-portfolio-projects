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

# Create Another Public Subnet
resource "aws_subnet" "subnet_b" {
  vpc_id                  = aws_vpc.main_vpc.id  # Reference the VPC ID
  cidr_block              = "10.0.2.0/24"       # Define the IP range for the subnet
  availability_zone       = "me-south-1b"       # Specify the availability zone
  map_public_ip_on_launch = true                # Enable auto-assign public IP
  tags = {
    Name = "subnet-b"                          # Add a tag for easier identification
  }
}

output "subnet_a_id" {
  value = aws_subnet.subnet_a.id
}

output "subnet_b_id" {
  value = aws_subnet.subnet_b.id
}
