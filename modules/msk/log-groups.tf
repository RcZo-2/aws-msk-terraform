resource "aws_cloudwatch_log_group" "msk_log_group" {
  name              = var.kafka_log_group_name
  retention_in_days = 30
}