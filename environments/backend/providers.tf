provider "aws" {
  region  = "ap-northeast-1"
  profile = "cli"
  default_tags {
    tags = {
      Name      = "${var.project}-s3-backend"
      TERRAFORM = "true"
      ENV       = "${var.env}"
      PROJECT   = "${var.project}"
      SOURCE    = "module-S3-backend"
    }
  }
}
