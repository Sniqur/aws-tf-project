output "private_subnet_id" {
  value = aws_subnet.public_subnet_1a.id
}

output "security_group_id" {
  value = aws_security_group.sg.id
}

