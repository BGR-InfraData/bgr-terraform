resource "aws_vpc" "bgr_infra" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "BGR-VPC"
  }
}

resource "aws_subnet" "sub_bgr_infra" {
  vpc_id                  = aws_vpc.bgr_infra.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-2a"
  map_public_ip_on_launch = true

  tags = {
    Name = "BGR-Subnet"
  }
}

resource "aws_internet_gateway" "gateway_from_bgr_infra" {
  vpc_id = aws_vpc.bgr_infra.id

  tags = {
    Name = "BGR-Internet-Gateway"
  }
}

resource "aws_route_table" "route_bgr_infra" {
  vpc_id = aws_vpc.bgr_infra.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gateway_from_bgr_infra.id
  }

  tags = {
    Name = "BGR-Route-Table"
  }
}

resource "aws_route_table_association" "this" {
  subnet_id      = aws_subnet.sub_bgr_infra.id
  route_table_id = aws_route_table.route_bgr_infra.id
}

resource "aws_instance" "bgr_infra" {
  ami           = var.ami
  instance_type = var.instance_type

  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.sg_bgr_infra.id]
  subnet_id              = aws_subnet.sub_bgr_infra.id

  tags = {
    Name = "bgr-infra-data"
  }
}
