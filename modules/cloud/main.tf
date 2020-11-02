resource "aws_vpc" "this" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

  tags = {
    Name = format("%s cloud", title(var.vpc_name))
  }
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = format("%s gateway", title(var.vpc_name))
  }
}
