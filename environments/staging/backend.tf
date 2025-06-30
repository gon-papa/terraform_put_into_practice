terraform {
  backend "s3" {
    profile      = "cli"
    bucket       = "tfstate-storage-9bfq28"
    key          = "staging/terraform.tfsstate"
    region       = "ap-northeast-1"
    use_lockfile = true
    encrypt      = true
    kms_key_id   = "alias/tfstate_storage_key_alias"
  }
}
