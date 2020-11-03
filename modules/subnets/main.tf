resource "aws_subnet" "this" {
  count = 2

  vpc_id     = var.vpc_id
  cidr_block = cidrsubnet(var.vpc_cidr, 8, var.offset + count.index)

  availability_zone = element(var.azs, count.index)

  tags = {
    Name = format("%s subnet", title(var.name))
  }
}

resource "aws_route_table" "this" {
  vpc_id = var.vpc_id

  tags = {
    Name = format("%s route table", title(var.name))
  }
}

resource "aws_route" "public" {
  count = var.gateway_id != null ? 1 : 0

  route_table_id         = aws_route_table.this.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = var.gateway_id
}

resource "aws_route_table_association" "this" {
  count = 2

  subnet_id      = aws_subnet.this[count.index].id
  route_table_id = aws_route_table.this.id
}
