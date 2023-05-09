output "instance_profile" {
  value = aws_iam_instance_profile.ec2_instance_profile.name
  description = "Instance profile for EC2 instances"
}
