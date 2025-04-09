resource "aws_security_group" "cdip_msk_sg" {
  name        = "cdip-msk-sg"
  description = "msk security group"
  vpc_id      = "vpc-xxxxxxxx"  # Provide the VPC ID where you want to create the security group

  ingress {
    from_port = 9096
    to_port   = 9096
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 2181
    to_port   = 2181
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 2182
    to_port   = 2182
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
