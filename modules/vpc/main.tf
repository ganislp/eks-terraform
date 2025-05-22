resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support
  tags                 = merge(var.common_tags, { Name = "${var.naming_prefix}-${var.vpc_name}" })
}

resource "aws_subnet" "public_subnet" {
  count                   = 2
  vpc_id                  = aws_vpc.this.id
  cidr_block              = cidrsubnet(var.vpc_cidr_block, 8, count.index)
  availability_zone       = data.aws_availability_zones.azs.names[count.index]
  map_public_ip_on_launch = true
  tags                    = merge(var.common_tags, { Name = "${var.naming_prefix}-public-${count.index + 1}" })
}

resource "aws_subnet" "private_subnet" {
  count                   = 2
  vpc_id                  = aws_vpc.this.id
  cidr_block              = cidrsubnet(var.vpc_cidr_block, 8, 2 + count.index)
  availability_zone       = data.aws_availability_zones.azs.names[count.index]
  map_public_ip_on_launch = false
  tags                    = merge(var.common_tags, { Name = "${var.naming_prefix}-private-${count.index + 1}" })
}



resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.this.id
  tags   = merge(var.common_tags, { Name = "${var.naming_prefix}-igw" })
}

resource "aws_eip" "eip" {
  depends_on = [aws_internet_gateway.igw]
}

resource "aws_nat_gateway" "public" {
  subnet_id     = aws_subnet.public_subnet[0].id
  allocation_id = aws_eip.eip.id
  depends_on    = [aws_internet_gateway.igw]
  tags          = merge(var.common_tags, { Name = "${var.naming_prefix}-natgw" })
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.this.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = merge(var.common_tags, { Name = "${var.naming_prefix}-public-rt" })
}

# resource "aws_default_route_table" "private_route_table" {
#   default_route_table_id = aws_vpc.this.default_route_table_id
#    tags = merge(var.common_tags, {
#     Name = "${var.naming_prefix}-priv-rtable"
#   })
# }

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.this.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.public.id
  }
  tags = merge(var.common_tags, {
    Name = "${var.naming_prefix}-priv-rtable"
  })
}

resource "aws_route_table_association" "public_rt_asso" {
  count          = 2
  route_table_id = aws_route_table.public_route_table.id
  subnet_id      = element(aws_subnet.public_subnet[*].id, count.index)
}

resource "aws_route_table_association" "private_rt_asso" {
  count          = 2
  route_table_id = aws_route_table.private_route_table.id
  subnet_id      = element(aws_subnet.private_subnet[*].id, count.index)
}