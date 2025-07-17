data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    profile    = "cli"
    bucket     = "tfstate-storage-9bfq28"
    key        = "network/terraform.tfstate"
    region     = "ap-northeast-1"
    encrypt    = true
    kms_key_id = "alias/tfstate_storage_key_alias"
  }
}
