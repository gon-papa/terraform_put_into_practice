module "tfstate_storage" {
  source  = "../../modules/tfstate_storage"
  env     = var.env
  project = var.project
}
