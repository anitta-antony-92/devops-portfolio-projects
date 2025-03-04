# modules/s3/s3.tf

# Create an S3 Bucket
resource "aws_s3_bucket" "devops_terraform_bucket" {
  bucket = "my-devops-terraform-ec2-project2-bucket-for-anitta"  # Ensure the bucket name is globally unique
  acl    = "private"                         # Set the bucket access control to private (default)

  tags = {
    Name = "devops_terraform_bucket"                  # Add a tag for easier identification
  }
}

# Output the S3 Bucket Name
output "s3_bucket_name" {
  value = aws_s3_bucket.devops_terraform_bucket.bucket
}
