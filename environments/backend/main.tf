module "tfstate_storage" {
  source  = "../../modules/tfstate_storage"
  project = var.project
  env     = var.env
}
