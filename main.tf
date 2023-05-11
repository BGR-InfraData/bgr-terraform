terraform {
  required_version = ">= 0.12"
}

module "iam" {
  source        = "./iam"
  iam_role_name = "ec2-bgr-infra"
}

module "vpc" {
  source = "./vpc"
}

module "security_group" {
  source = "./securitygroup"
  vpc_id = module.vpc.vpc_id
}

module "ec2" {
  source                    = "./ec2"
  ami_id                    = var.ami_id
  instance_type             = var.instance_type
  subnet_id                 = module.vpc.public_subnets[0]
  security_group_id         = module.security_group.security_group_id
  iam_instance_profile      = module.iam.iam_role_name
  instance_name             = var.instance_name
  ebs_volume_size           = var.ebs_volume_size
  ebs_volume_type           = var.ebs_volume_type
  ebs_delete_on_termination = var.ebs_delete_on_termination
}

module "s3" {
  source         = "./s3"
  aws_account_id = var.aws_account_id
}