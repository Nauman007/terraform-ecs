resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr

  tags = merge(var.default_tags, {
    Name        = "vpc-${var.env}-${var.project_name}"
    description = "VPC for ${var.env}-${var.project_name}"
  })
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = merge(var.default_tags, {
    Name        = "igw-${var.env}-${var.project_name}"
    description = "igw for ${var.env}-${var.project_name}"
  })
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidr[0]
  map_public_ip_on_launch = true

  tags = merge(var.default_tags, {
    Name        = "public-subnet-${var.env}-${var.project_name}"
    description = "public subnet for ${var.env}-${var.project_name}"
  })
}

resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.private_subnet_cidr[0]

  tags = merge(var.default_tags, {
    Name        = "private-subnet-${var.env}-${var.project_name}"
    description = "private subnet for ${var.env}-${var.project_name}"
  })
}

resource "aws_eip" "nat" {
  count = var.create_nat_gateway ? 1 : 0
  vpc   = true
  tags = merge(var.default_tags, {
    Name        = "eip-nat-gw-${var.env}-${var.project_name}"
    description = "eip-nat-gw for ${var.env}-${var.project_name}"
  })
}

resource "aws_nat_gateway" "nat" {
  count         = var.create_nat_gateway ? 1 : 0
  allocation_id = aws_eip.nat[0].id
  subnet_id     = aws_subnet.public.id

  tags = merge(var.default_tags, {
    Name        = "nat-gw-${var.env}-${var.project_name}"
    description = "nat-gw for ${var.env}-${var.project_name}"
  })
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = merge(var.default_tags, {
    Name        = "public-rt-${var.env}-${var.project_name}"
    description = "public-rt for ${var.env}-${var.project_name}"
  })
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id
  #   count  = var.create_nat_gateway ? 1 : 0

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.create_nat_gateway ? aws_nat_gateway.nat[0].id : aws_internet_gateway.igw.id
  }

  tags = merge(var.default_tags, {
    Name        = "private-rt-${var.env}-${var.project_name}"
    description = "private-rt for ${var.env}-${var.project_name}"
  })
}

resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}


