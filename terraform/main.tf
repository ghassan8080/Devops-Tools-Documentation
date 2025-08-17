# Using t2.micro for test environment - 1 vCPU, 1 GB RAM in eu-west-2 (London)
resource "aws_instance" "ubuntu-instance" {
  ami           = var.ami
  instance_type = "t2.micro"
  key_name      = aws_key_pair.UbuntuKP.key_name
  vpc_security_group_ids = [aws_security_group.UbuntuSG.id]
  subnet_id     = aws_subnet.main.id
  associate_public_ip_address = true

  tags = {
    Name = "Ubuntu-EC2"
    Environment = "production"
    Project = "devops-pipeline"
  }

  # The default storage size of the created EC2 will be 8GB SSD and since we will be running minikube, kubectl and docker we will need more storage 
  # So in this example we will make the storage 30GB which is the maximum free storage you can use
  root_block_device {
    volume_size = 30
    volume_type = "gp3"
    encrypted   = true
    delete_on_termination = true
  }

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y docker
              systemctl start docker
              systemctl enable docker
              usermod -a -G docker ec2-user
              EOF
}

# Create VPC
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "main-vpc"
  }
}

# Create subnet
resource "aws_subnet" "main" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "${var.region}a"
  map_public_ip_on_launch = true

  tags = {
    Name = "main-subnet"
  }
}

# Create internet gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main-igw"
  }
}

# Create route table
resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "main-rt"
  }
}

# Associate route table with subnet
resource "aws_route_table_association" "main" {
  subnet_id      = aws_subnet.main.id
  route_table_id = aws_route_table.main.id
}


