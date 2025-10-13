resource "aws_security_group" "bastion_sg" {
  name        = "${var.bastion_server_name}-sg"
  description = "Bastion security group"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
