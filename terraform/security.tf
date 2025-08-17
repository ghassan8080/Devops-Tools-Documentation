# Create security group 
resource "aws_security_group" "UbuntuSG" {
  name        = "ubuntu-sg"
  description = "Security group for Ubuntu EC2 instance"
  vpc_id      = aws_vpc.main.id

  # Port 22 for SSH to connect to the EC2 instance 
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Port 8080 is the default port to run Jenkins 
  ingress {
    description = "Jenkins"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # We will use Port 5000 to run php-apache, you can choose any port but make sure it is the same in the docker-compose.yml 
  ingress {
    description = "Laravel App"
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Port 3306 is the default port for the database to run 
  ingress {
    description = "MySQL"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # We will use port 4000 to run phpmyadmin, you can choose any port but make sure it is the same in the docker-compose.yml
  ingress {
    description = "phpMyAdmin"
    from_port   = 4000
    to_port     = 4000 
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTPS for secure connections
  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP for redirects
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ubuntu-sg"
  }
}

# Set the keypair criteria
resource "tls_private_key" "pk" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Create and download the keypair 
resource "aws_key_pair" "UbuntuKP" {
  key_name   = "mykey"
  public_key = tls_private_key.pk.public_key_openssh

  tags = {
    Name = "ubuntu-keypair"
  }
}

# Output the private key
resource "local_file" "private_key" {
  content  = tls_private_key.pk.private_key_pem
  filename = "mykey.pem"
  file_permission = "0400"
}
