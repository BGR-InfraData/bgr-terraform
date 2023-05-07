module "ec2_bgr_infra" {
  source         = "./ec2_module"
  key_name       = "kubernetes-cka"
  ami            = "ami-0a695f0d95cefc163"
  instance_type  = "t2.medium"
}
