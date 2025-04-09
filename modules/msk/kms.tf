resource "aws_kms_key" "msk_encryption_key" {
  description = "KMS key for MSK encryption"
  enable_key_rotation = false
}