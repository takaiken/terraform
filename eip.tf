resource "aws_eip" "nat_1a" {
  vpc = true

  tags = {
    Name = "handson-natgw-1a"
  }
}

resource "aws_eip" "nat_1c" {
  vpc = true

  tags = {
    Name = "handson-natgw-1c"
  }
}
