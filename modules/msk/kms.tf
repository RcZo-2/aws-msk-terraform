resource "aws_kms_key" "msk_encryption_key" {
  description         = "KMS key for MSK encryption"
  enable_key_rotation = false
}

resource "aws_kms_alias" "msk_key_alias" {
  name          = "alias/your-msk-encryption-key-name"
  target_key_id = aws_kms_key.msk_encryption_key.id
}