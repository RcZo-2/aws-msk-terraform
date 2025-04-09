resource "aws_secretsmanager_secret" "kafka_secrets" {
  for_each   = {for user in var.msk_users : user => user}
  name       = "AmazonMSK_${each.key}"
  kms_key_id = aws_kms_key.msk_encryption_key.id
}

resource "aws_secretsmanager_secret_version" "kafka_secrets" {
  for_each  = {for user in var.msk_users : user => user}
  secret_id = aws_secretsmanager_secret.kafka_secrets[each.key].id
  secret_string = jsonencode({
    username : each.key, password : random_password.msk_password[each.key].result
  })

  depends_on = [
    aws_secretsmanager_secret.kafka_secrets
  ]
}

resource "aws_secretsmanager_secret_policy" "kafka_secrets" {
  for_each = toset(var.msk_users)
  secret_arn = aws_secretsmanager_secret.kafka_secrets[each.key].arn
  policy     = <<POLICY
{
  "Version" : "2012-10-17",
  "Statement" : [ {
    "Sid": "AWSKafkaResourcePolicy",
    "Effect" : "Allow",
    "Principal" : {
      "Service" : "kafka.amazonaws.com"
    },
    "Action" : "secretsmanager:getSecretValue",
    "Resource" : "${aws_secretsmanager_secret.kafka_secrets["${each.key}"].arn}"
  } ]
}
POLICY

  depends_on = [
    aws_secretsmanager_secret.kafka_secrets
  ]
}

resource "aws_msk_scram_secret_association" "kafka" {
  cluster_arn = aws_msk_cluster.kafka.arn
  secret_arn_list = flatten([
    for user in var.msk_users :
    "${aws_secretsmanager_secret.kafka_secrets["${user}"].arn}"
  ])

  depends_on = [aws_secretsmanager_secret_version.kafka_secrets]
}

resource "random_password" "msk_password" {
  for_each = toset(var.msk_users)
  length           = 8
  special          = true
  override_special = "!*#$%&^@"
}
