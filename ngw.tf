resource "aws_nat_gateway" "nat_1a" {
  subnet_id = "${aws_subnet.public_1a.id}"
  allocation_id = "${aws_eip.nat_1a.id}"

  tags = {
    Name = "handson-1a"
  }
}

resource "aws_nat_gateway" "nat_1c" {
  subnet_id = "${aws_subnet.public_1c.id}"
  allocation_id = "${aws_eip.nat_1c.id}"

  tags = {
    Name = "handson-1c"
  }
}
