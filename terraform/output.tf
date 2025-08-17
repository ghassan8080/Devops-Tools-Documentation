output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.ubuntu-instance.public_ip
}

output "instance_public_dns" {
  description = "Public DNS name of the EC2 instance"
  value       = aws_instance.ubuntu-instance.public_dns
}

output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main.id
}

output "subnet_id" {
  description = "ID of the subnet"
  value       = aws_subnet.main.id
}

output "security_group_id" {
  description = "ID of the security group"
  value       = aws_security_group.UbuntuSG.id
}

output "connection_instructions" {
  description = "Instructions to connect to the instance"
  value       = "ssh -i mykey.pem ubuntu@${aws_instance.ubuntu-instance.public_ip}"
}