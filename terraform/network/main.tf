data "aws_availability_zones" "available" {}
# henter liste over tilgjengelige AZ navn i regionen
# og brukes til å spre subnets for høy tilgjengelighet

resource "aws_vpc" "main_vpc" {
  cidr_block = var.vpc_cidrblock
  tags = {
    Name = "${var.name_prefix}-vpc"
  }
}

resource "aws_subnet" "public_subnet" {
  cidr_block              = var.public_cidr
  vpc_id                  = aws_vpc.main_vpc.id
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.name_prefix}-public-subnet"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    Name = "${var.name_prefix}-internet-gateway"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.name_prefix}-route-table"
  }
}

resource "aws_route_table_association" "public_route" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}
