output "vpc_name" {
  value = module.vpc.name
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "intra_subnets" {
  value = module.vpc.intra_subnet_objects
}

output "private_subnets" {
  value = module.vpc.private_subnet_objects
}

output "public_subnets" {
  value = module.vpc.public_subnet_objects
}
