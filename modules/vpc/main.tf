# ============================
# VPCモジュール
# ============================

# 利用可能なAZをまとめて取得
data "aws_availability_zones" "current" {}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "6.0.1"

  name = "${var.project}-${var.env}-vpc"
  cidr = var.cidr

  azs = [
    "ap-northeast-1a",
    "ap-northeast-1c",
    "ap-northeast-1d",
  ]

  public_subnets = [
    cidrsubnet(var.cidr, 4, 0),
    cidrsubnet(var.cidr, 4, 1),
    cidrsubnet(var.cidr, 4, 2)
  ]

  private_subnets = [
    cidrsubnet(var.cidr, 4, 4),
    cidrsubnet(var.cidr, 4, 5),
    cidrsubnet(var.cidr, 4, 6)
  ]

  intra_subnets = [
    cidrsubnet(var.cidr, 4, 8),
    cidrsubnet(var.cidr, 4, 9),
    cidrsubnet(var.cidr, 4, 10),
  ]

  enable_nat_gateway = true

  enable_dns_support   = true
  enable_dns_hostnames = true

}
