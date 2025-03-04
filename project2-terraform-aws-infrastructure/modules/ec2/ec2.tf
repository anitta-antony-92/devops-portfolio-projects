# modules/ec2/ec2.tf

variable "subnet_id" {}

# Create an EC2 Instance
resource "aws_instance" "my-devops-terraform-ec2-project2" {
  ami           = "ami-0a95ef992b0368b4c"  # Replace with a valid AMI for your region (e.g., Amazon Linux 2)
  instance_type = "t3.micro"               # Free Tier eligible instance type
  subnet_id     =  var.subnet_id  # Attach to the first subnet created in the VPC module
  key_name      = "my-devops-flask-app-ec2-keypair"          # Replace with your SSH key pair name

  tags = {
    Name = "my-devops-terraform-ec2-project2"             # Add a tag for easier identification
  }
}

# Output the Public IP of the EC2 Instance
output "ec2_public_ip" {
  value = aws_instance.my-devops-terraform-ec2-project2.public_ip
}