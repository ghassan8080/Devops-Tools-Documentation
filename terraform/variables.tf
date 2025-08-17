# Adding the region as a variable, used in provider.tf
variable "region" {
  type    = string 
  default = "eu-west-2"
  description = "AWS region to deploy resources"
}

# Adding the ami as a variable, used in main.tf 
variable "ami" {
  type    = string 
  default = "ami-051fd0ca694aa2379" # Ubuntu 22.04 LTS in eu-west-2 (London)
  description = "AMI ID for the EC2 instance"
}

# Environment variable
variable "environment" {
  type    = string
  default = "production"
  description = "Environment name"
}

# Instance type variable
variable "instance_type" {
  type    = string
  default = "t3.micro"
  description = "EC2 instance type"
}

# Create terraform.tfvars and add your public ssh key in 
variable "public_key" {
  description = "ssh public key"
}