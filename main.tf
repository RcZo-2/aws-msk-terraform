terraform {
  required_providers {
    aws = {
      version = "5.94.1"
    }
  }
}

# msk
module "cluster" {
  #   aws_profile = var.aws_profile
  aws_region = "ap-southeast-1"

  kafka_cluster_name           = "msk-97639"
  kafka_version                = "3.6.0"
  kafka_number_of_broker_nodes = 2
  kafka_instance_type          = "kafka.m7g.large"
  kafka_ebs_volume_size        = 100
  kafka_scaling_max_capacity   = 200
  kafka_client_subnets = [
    "subnet-00000000000000000",
    "subnet-00000000000000001",
  ]
  #kafka_security_groups = ["sg-00000000000000000"]

  server_properties = <<PROPERTIES
auto.create.topics.enable=false
default.replication.factor=2
min.insync.replicas=1
num.io.threads=8
num.network.threads=5
num.partitions=2
num.replica.fetchers=2
replica.lag.time.max.ms=30000
socket.receive.buffer.bytes=102400
socket.request.max.bytes=104857600
socket.send.buffer.bytes=102400
unclean.leader.election.enable=true
zookeeper.session.timeout.ms=18000
PROPERTIES

  msk_users = [
    {
      username = "msk-user"
      password = random_password.password.result
    }
  ]

  source = "./modules/msk"
}

resource "random_password" "password" {
  length           = 8
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}
