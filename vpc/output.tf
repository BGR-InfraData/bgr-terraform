output "vpc_id" {
  value = aws_vpc.vpc_bgr_infra.id
}

output "public_subnets" {
  value = aws_subnet.sub_bgr_infra.*.id
}
