output "instance_id" {
  value = aws_instance.ec2_bgr_infra.id
}

output "instance_public_ip" {
  value = aws_instance.ec2_bgr_infra.public_ip
}
