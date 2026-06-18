output "jenkins_docker_instance_profile" {
  value = module.iam_role_eks_jenkins_docker.role_instance_profile
}