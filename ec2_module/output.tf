output "instance_public_ip" {
  value       = aws_instance.bgr_infra.public_ip
}
