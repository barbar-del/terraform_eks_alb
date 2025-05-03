data "http" "myip" {
  url = "https://ipv4.icanhazip.com"
}

resource "aws_security_group" "eks_sg" {
  name        = "eks-security-group"
  description = "Security group for EKS"
  vpc_id      = aws_vpc.my_vpc.id


# ask nitzan

  ingress {
    from_port   = 30000
    to_port     = 30000
    protocol    = "tcp"
    cidr_blocks = ["${chomp(data.http.myip.response_body)}/32"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_security_group" "sg_group" {
    name = "sg_group"
    description = "Security group"
    vpc_id = aws_vpc.my_vpc.id

    ingress {
        description = "security group"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        ipv6_cidr_blocks = [ "::/0" ]
    }

}

