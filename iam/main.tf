data "aws_iam_role" "role_bgr_infra" {
  name = var.iam_role_name
}

resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "bgr_infra"
  role = data.aws_iam_role.role_bgr_infra.name
}
