output "bucket" {
  value = aws_s3_bucket.tfstate_storage.id
}

output "kms_key_arn" {
  value = aws_kms_key.tfstate_storage.arn
}
