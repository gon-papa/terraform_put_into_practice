# ============================
# ECSの連携サービス
# ============================
module "ecs_infra" {
  source  = "../../modules/ecs_infra"
  env     = var.env
  project = var.project
}

# ============================
# ECSのIAM関連
# ============================
module "ecs_iam" {
  source                = "../../modules/ecs_iam"
  env                   = var.env
  project               = var.project
  session_parameter_arn = module.ecs_infra.env_parameter_arn
}

# ============================
# ECS Cluster
# ============================
module "ecs_cluster" {
  source  = "../../modules/ecs_cluster"
  env     = var.env
  project = var.project
}

# ============================
# ECS Service
# ============================
# module "ecs_cluster" {
#   source          = "../../modules/ecs_service"
#   env             = var.env
#   project         = var.project
#   vpc_name        = data.terraform_remote_state.vpc.outputs.vpc_name
#   vpc_id          = data.terraform_remote_state.vpc.outputs.vpc_id
#   public_subnets  = data.terraform_remote_state.vpc.outputs.public_subnet_ids
#   private_subnets = data.terraform_remote_state.vpc.outputs.private_subnets_ids
# }
