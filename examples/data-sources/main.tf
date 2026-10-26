# Example: Using AWS Data Sources
# Best practice: Use data sources to query existing infrastructure

# Get current AWS account information
data "aws_caller_identity" "current" {}

# Get current AWS region
data "aws_region" "current" {}

# Get all available availability zones
data "aws_availability_zones" "available" {
  #checkov:skip=CKV_AWS_394:Example code; AZ list intentionally not pinned
  state = "available"
}

# Query default VPC
data "aws_vpc" "default" {
  default = true
}

# Query subnets in the default VPC
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# Get the latest Amazon Linux 2 AMI
data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Get the latest Ubuntu AMI
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Query existing S3 bucket (example - will fail if bucket doesn't exist)
# data "aws_s3_bucket" "existing" {
#   bucket = "my-existing-bucket-name"
# }

# Get AWS SSM Parameter (example for retrieving secrets)
# data "aws_ssm_parameter" "database_password" {
#   name = "/myapp/database/password"
# }

# Best practices for data sources:
# 1. Use data sources to query existing infrastructure
# 2. Combine data sources with resources for dynamic configurations
# 3. Use filters to narrow down queries
# 4. Cache results with lifecycle ignore_changes if appropriate
# 5. Handle potential failures with try() or count
