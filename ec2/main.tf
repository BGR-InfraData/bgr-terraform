module "vpc" {
  source = "../vpc"
}
#tfsec:ignore:aws-ec2-no-public-egress-sgr
#tfsec:ignore:aws-vpc-no-public-egress-sgr
#tfsec:ignore:aws-ec2-no-public-ingress-sgr
module "security_group" {
  source = "../securitygroup"
  vpc_id = module.vpc.vpc_id
}

module "iam" {
  source        = "../iam"
  iam_role_name = "ec2-bgr-infra"
}

#tfsec:ignore:aws-ec2-enable-at-rest-encryption
#tfsec:ignore:aws-ec2-enforce-http-token-imds
#tfsenc:ignore:aws-ec2-add-description-to-security-group-rule
resource "aws_instance" "ec2_bgr_infra" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id

  #tfsec:ignore:aws-ec2-no-public-egress-sgr
  #tfsec:ignore:aws-vpc-no-public-egress-sgr
  #tfsec:ignore:aws-ec2-no-public-ingress-sgr
  #tfsec:ignore:aws-ec2-add-description-to-security-group-rule
  vpc_security_group_ids      = [var.security_group_id]
  associate_public_ip_address = true

  iam_instance_profile = module.iam.role_name

  tags = {
    Name = var.instance_name
    App  = "bgr-infra"
  }

  # Configuração do volume EBS
  #tfsec:ignore:aws-ec2-enable-at-rest-encryption
  root_block_device {
    volume_size           = var.ebs_volume_size
    volume_type           = var.ebs_volume_type
    delete_on_termination = var.ebs_delete_on_termination
  }
  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update -y
              sudo apt-get install -y docker.io
              sudo systemctl enable --now docker
              sudo usermod -aG docker ubuntu
              sudo docker network create frontend --driver bridge
              sudo apt-get install jq -y


              sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
              sudo chmod +x /usr/local/bin/docker-compose
              sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

              # Install AWS SSM Agent
              sudo apt-get install -y snapd
              sudo snap install amazon-ssm-agent --classic
              sudo systemctl enable --now snap.amazon-ssm-agent.amazon-ssm-agent.service

              # aws cli

               apt-get update
               apt-get install -y unzip curl
               curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
               unzip awscliv2.zip
               sudo ./aws/install

              EOF
}
