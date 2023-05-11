variable "ami_id" {
  description = "ID da AMI para a instância EC2"
  type        = string
  default     = "ami-0a695f0d95cefc163"
}

variable "instance_type" {
  description = "Tipo da instância EC2"
  type        = string
  default     = "t2.large"
}

variable "instance_name" {
  description = "Nome da instância EC2"
  type        = string
  default     = "bgr_infra"
}

variable "ebs_volume_size" {
  description = "Size of the additional EBS volume"
  type        = number
  default     = 50
}

variable "ebs_volume_type" {
  description = "Type of the additional EBS volume"
  type        = string
  default     = "gp2"
}

variable "ebs_delete_on_termination" {
  description = "Whether the additional EBS volume should be deleted when the EC2 instance is terminated"
  type        = bool
  default     = true
}

variable "aws_account_id" {
  description = "AWS Account ID"
  type        = string
  default     = "444860385156"
}

variable "aws_user" {
  description = "AWS Account ID"
  type        = string
  default     = "bgr-infra-data"
}