terraform {
  backend "s3" {
    bucket = "bgr-infra-tfstate"
    key          = "terraform/backend/terraform.tfstate"
    region = "us-east-2"
  }
}