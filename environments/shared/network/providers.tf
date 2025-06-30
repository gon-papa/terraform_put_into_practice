provider "aws" {
  region  = "ap-northeast-1"
  profile = "cli"

  default_tags {
    tags = {
      Name      = "${var.project}-vpc"
      TERRAFORM = "true"
      ENV       = "${var.env}"
      PROJECT   = "${var.project}"
      SOURCE    = "module-VPC"
    }
  }
}
