variable "ports" {
  description = "Portas a serem liberadas no Security Group"
  type        = list(number)
  default     = [8080, 5000, 8200, 5555, 8081, 9090, 3000, 443, 80, 9000]
}

variable "vpc_id" {
  description = "ID da VPC"
  type        = string
}