variable "aws_profile" {
  type        = string
  description = "AWS CLI profile to use (e.g., 'dev' or 'demo')"
}

variable "aws_region" {
  type        = string
  description = "AWS region to deploy to"
  default     = "us-east-1"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "vpc_name" {
  type        = string
  description = "Name for the VPC"
  default     = "my-vpc"
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "List of CIDRs for public subnets"
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "List of CIDRs for private subnets"
}

variable "availability_zones" {
  type        = list(string)
  description = "List of availability zones to use"
}

variable "app_port" {
  type        = number
  description = "The port number for the application"
  default     = 8080
}

variable "custom_ami_id" {
  description = "The custom AMI ID built using Packer"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.small"
}

variable "key_name" {
  description = "AWS EC2 key pair name to enable SSH access"
  type        = string
}


variable "db_master_password" {
  description = "Master password for the RDS instance"
  type        = string
  sensitive   = true
}


variable "db_url" {
  type        = string
  description = "Database connection URL (e.g., jdbc:mysql://<host>:<port>/dbname)"
}

variable "db_username" {
  type        = string
  description = "Database username for connecting to the database"
}

variable "db_password" {
  type        = string
  description = "Database password for connecting to the database"
  sensitive   = true
}


