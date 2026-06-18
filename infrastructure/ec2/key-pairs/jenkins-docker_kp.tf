module "jenkins_docker" {
  source = "../../../modules/ec2/key-pairs"

  key_pair_name = "jenkins-docker"
  environment   = var.environment
}