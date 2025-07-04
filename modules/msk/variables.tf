variable "aws_region" {
  description = "aws region"
  default     = "ap-southeast-1"
}
variable "aws_profile" {
  description = "Profile in aws/config"
  default     = ""
}

variable "msk_users" {
  type = list(string)
}

variable "server_properties" {
  type = string
}

variable "kafka_cluster_name" {
  type = string
}

variable "kafka_version" {
  type = string
}

variable "kafka_number_of_broker_nodes" {
  type = string
}
variable "kafka_instance_type" {
  type = string
}
variable "kafka_ebs_volume_size" {
  type = number
}

variable "kafka_client_subnets" {
  type = list(any)
}

# variable "kafka_security_groups" {
#   type = list(any)
# }

variable "kafka_scaling_max_capacity" {
  type = number
}

variable "kafka_log_group_name" {
  type    = string
  default = "/your-msk-log-group-name"
}

variable "vpc_id" {
  description = "The VPC ID where resources will be created."
  type        = string
}
