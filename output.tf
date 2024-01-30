output "vpc_id" {
  value = module.vpc.vpc_id
}
output "igw_id" {
  value = module.vpc.igw_id
}
output "public_subnet_ids" {
  value = module.dynamic_subnets.public_subnet_ids
}
output "private_subnet_ids" {
  value = module.dynamic_subnets.private_subnet_ids
}
output "eks_cluster_name" {
  value = module.eks_cluster.eks_cluster_id
}
output "bastion_ip" {
  value = module.bastion.public_ip
}
output "bastion_id" {
  value = module.bastion.id
}
# output "jenkins_server_ip" {
#   value = module.jenkins_server.private_ip
# }
# output "jenkins_server_id" {
#   value = module.jenkins_server.id

# }
# output "sonarqube_ip" {
#   value = module.sonarqube.public_ip
# }
# output "sonarqube_id" {
#   value = module.sonarqube.id
# }