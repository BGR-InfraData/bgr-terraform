terraform {
  required_version = ">= 0.13"
}

module "iam" {
  source        = "./iam"
  iam_role_name = "ec2-bgr-infra"
}

#tfsec:ignore:aws-ec2-require-vpc-flow-logs-for-all-vpcs
module "vpc" {
  source = "./vpc"
}

#tfsec:ignore:aws-ec2-no-public-egress-sgr
#tfsec:ignore:aws-vpc-no-public-egress-sgr
#tfsec:ignore:aws-ec2-no-public-ingress-sgr
#tfsec:ignore:aws-ec2-add-description-to-security-group-rule
module "security_group" {
  source = "./securitygroup"
  vpc_id = module.vpc.vpc_id
}

#tfsec:ignore:aws-ec2-no-public-egress-sgr
#tfsec:ignore:aws-vpc-no-public-egress-sgr
#tfsec:ignore:aws-ec2-no-public-ingress-sgr
#tfsec:ignore:aws-ec2-enable-at-rest-encryption
#tfsec:ignore:aws-ec2-enforce-http-token-imds
#tfsec:ignore:aws-ec2-add-description-to-security-group-rule
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

#tfsec:ignore:aws-s3-enable-versioning
#tfsec:ignore:aws-s3-enable-bucket-logging
#tfsec:ignore:aws-s3-encryption-customer-key
#tfsec:ignore:aws-s3-enable-bucket-encryption
#tfsec:aws-s3-specify-public-access-block
#tfsec:aws-s3-ignore-public-acls
#tfsec:aws-s3-no-public-buckets
#tfsec:aws-s3-block-public-policy
#tf:aws-s3-block-public-acls
module "s3" {
  source         = "./s3"
  aws_access_iam = var.aws_access_iam
  aws_account_id = var.aws_account_id
}
