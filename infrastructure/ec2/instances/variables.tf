variable "aws_profile" {}
variable "aws_region" {}
variable "environment" {}
variable "state_bucket_name" {}
variable "state_file_name" {}

### Jenkins Instances

variable "instance_name_jenkins_docker" {
  default     = "jenkins-docker"
  description = "The name of the Jenkins Docker instance"
  type        = string
}

variable "instance_type_jenkins_docker" {
  default     = "c7i-flex.large"
  description = "The instance type"
  type        = string
}

# Jenkins Instances Tags

variable "instance_os_linux_tag" {
  default     = "Linux"
  description = "The instance operating system"
  type        = string
}

variable "instance_purpose_jenkins_docker_tag" {
  default     = "Jenkins-Docker"
  description = "The instance purpose"
  type        = string
}

variable "instance_role_docker_host_tag" {
  default     = "Docker-Host"
  description = "The instance role"
  type        = string
}