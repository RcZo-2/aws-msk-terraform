resource "aws_instance" "your-bastion-server-name" {
  ami                  = "ami-05ab12222a9f39021"
  instance_type        = "t2.micro"
  subnet_id            = var.subnet_id
  iam_instance_profile = "maybe-xxxx-runner"

  tags = {
    Name = "your-bastion-server-name"
  }

  user_data = <<EOF
#!/bin/bash
yum update -y
yum install java-17-amazon-corretto -y
wget https://archive.apache.org/dist/kafka/${var.kafka_version}/kafka_2.12-${var.kafka_version}.tgz
tar -zxf kafka_2.12-${var.kafka_version}.tgz
mv kafka_2.12-${var.kafka_version} /usr/local/kafka
rm kafka_2.12-${var.kafka_version}.tgz
EOF
}