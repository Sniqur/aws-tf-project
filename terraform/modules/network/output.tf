output "prvt_subnet_id" {
  value = aws_subnet.private_subnet.id
}

output "public1_subnet_id" {
  value = aws_subnet.public_subnet_1a.id
}

output "sec_group_id" {
  value = aws_security_group.sg.id
}