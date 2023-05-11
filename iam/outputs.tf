output "role_name" {
  value = data.aws_iam_role.role_bgr_infra.name
  description = "Nome da IAM role para ser anexada às instâncias EC2"
}

output "iam_role_name" {
  value = data.aws_iam_role.role_bgr_infra.name
  description = "The name of the IAM role to attach to the EC2 instance"
}
