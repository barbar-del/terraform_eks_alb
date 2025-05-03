output "public_subnets" {
  value = aws_subnet.public_subnet[*].id
}

output "private_subnets" {
  value = aws_subnet.private_subnet[*].id
}

output "sg_group" {
  value = aws_security_group.sg_group.id
}

output "vpc_id" {
  value = aws_vpc.my_vpc.id
}
output "eks_sg_group" {
  value = aws_security_group.eks_sg.id
}
