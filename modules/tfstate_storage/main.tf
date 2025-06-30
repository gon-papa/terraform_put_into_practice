# ============================
# S3モジュール
# ============================

# ユニーク名のためのランダム値
resource "random_string" "s3_unique_key" {
  length  = 6
  upper   = false
  lower   = true
  numeric = true
  special = false
}

resource "aws_s3_bucket" "tfstate_storage" {
  bucket = "tfstate-storage-${random_string.s3_unique_key.result}"
}

resource "aws_s3_bucket_versioning" "tfstate_storage" {
  bucket = aws_s3_bucket.tfstate_storage.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "tfstate_storage" {
  bucket = aws_s3_bucket.tfstate_storage.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "tfstate_storage" {
  bucket = aws_s3_bucket.tfstate_storage.id
  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.tfstate_storage.arn
      sse_algorithm     = "aws:kms"
    }
  }
}

# ============================
# KMSモジュール
# ============================
resource "aws_kms_key" "tfstate_storage" {
  description             = "tfstateファイル暗号化キー"
  deletion_window_in_days = 7
  enable_key_rotation     = true
}

resource "aws_kms_alias" "tfstate_storage" {
  name          = "alias/tfstate_storage_key_alias"
  target_key_id = aws_kms_key.tfstate_storage.id
}
