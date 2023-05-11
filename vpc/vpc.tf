resource "aws_vpc" "vpc_bgr_infra" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = "bgr_infra"
  }
}

resource "aws_subnet" "sub_bgr_infra" {
  count = length(var.public_subnets_cidr_blocks)

  cidr_block = var.public_subnets_cidr_blocks[count.index]
  vpc_id     = aws_vpc.vpc_bgr_infra.id
  tags = {
    Name = "bgr-infra-public-subnet-${count.index + 1}"
  }
}

resource "aws_internet_gateway" "gateway_igw_bgr" {
  vpc_id = aws_vpc.vpc_bgr_infra.id
}

resource "aws_route_table" "rt_bgr_infra" {
  vpc_id = aws_vpc.vpc_bgr_infra.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gateway_igw_bgr.id
  }
}

resource "aws_route_table_association" "rta_bgr_infra" {
  count = length(aws_subnet.sub_bgr_infra)

  subnet_id      = aws_subnet.sub_bgr_infra[count.index].id
  route_table_id = aws_route_table.rt_bgr_infra.id
}

