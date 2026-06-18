module "ec2_instance_jenkins_docker" {
  source = "../../../modules/ec2/instances/jenkins/"

  ami_id           = data.aws_ami.aws_linux_latest.id
  instance_name    = var.instance_name_jenkins_docker
  instance_profile = data.terraform_remote_state.iam_roles.outputs.jenkins_docker_instance_profile

  instance_type = var.instance_type_jenkins_docker
  key_pair_name = data.terraform_remote_state.key_pairs.outputs.jenkins_docker_name

  security_groups_ids = [
    data.terraform_remote_state.security_groups.outputs.jenkins_docker_id
  ]

  subnet_id = data.terraform_remote_state.vpc.outputs.private_subnet_a_id

  # Tags
  instance_purpose_tag = var.instance_purpose_jenkins_docker_tag
  instance_os_tag      = var.instance_os_jenkins_docker_tag
  instance_role_tag    = var.instance_role_jenkins_docker_tag
}