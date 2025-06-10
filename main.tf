terraform {
  required_providers {
    aws = {
      version = "5.94.1"
    }
  }
}

data "aws_vpc" "selected" {
  filter {
    name   = "tag:Name"
    values = ["your-vpc-name"]
  }
}

data "aws_subnets" "selected" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.selected.id]
  }
  filter {
    name   = "tag:Name"
    values = ["*private*"]
  }
}

# msk
module "cluster" {
  #   aws_profile = var.aws_profile
  aws_region = "ap-southeast-1"
  vpc_id = data.aws_vpc.selected.id

  kafka_cluster_name           = "your-msk-name"
  kafka_version                = "3.6.0"
  kafka_number_of_broker_nodes = 3
  kafka_instance_type          = "kafka.m7g.large"
  kafka_ebs_volume_size        = 100
  kafka_scaling_max_capacity   = 200
  kafka_client_subnets = data.aws_subnets.selected.ids
  #kafka_security_groups = ["sg-00000000000000000"]

  server_properties = <<PROPERTIES
auto.create.topics.enable=false
default.replication.factor=3
min.insync.replicas=2
num.io.threads=8
num.network.threads=5
num.partitions=3
num.replica.fetchers=2
replica.lag.time.max.ms=30000
socket.receive.buffer.bytes=102400
socket.request.max.bytes=104857600
socket.send.buffer.bytes=102400
unclean.leader.election.enable=true
zookeeper.session.timeout.ms=18000
PROPERTIES

  msk_users = [
    "msk-user-01",
    "msk-user-02"
  ]

 
  source = "./modules/msk"
}

module "bastion" {
  bastion_server_name = "your-ec2-name"
  subnet_id           = data.aws_subnets.selected.ids[0]
  kafka_version       = "3.6.0"

  source        = "./modules/bastion"
}