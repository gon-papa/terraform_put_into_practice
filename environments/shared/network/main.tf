module "vpc" {
  source  = "../../../modules/vpc"
  env     = "all"
  cidr    = "10.0.0.0/16"
  project = "myteam"
}
