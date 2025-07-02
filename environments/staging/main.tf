# ============================
# backendバケット
# ============================
module "tfstate_storage" {
  source  = "../../modules/tfstate_storage"
  env     = var.env
  project = var.project
}

# ============================
# ECSの連携サービス
# ============================
module "ecs_infra" {
  source  = "../../modules/ecs_infra"
  env     = var.env
  project = var.project
}
