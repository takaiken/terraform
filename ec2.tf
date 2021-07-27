resource "aws_instance" "sandbox" {
  count         = 2
  ami           = "ami-785c491f"
  instance_type = "t2.micro"

  tags = {
    Name = "${format("sandbox-%02d", count.index + 1)}"
  }
}


resource "aws_vpc" "main" {
	cidr_block = "10.0.0.0/16"

	tags = {
		Name = "handson"
	}
}

resource "aws_subnet" "public_1a" {
	vpc_id = "${aws_vpc.main.id}"

	availability_zone = "ap-northeast-1a"

	cidr_block = "10.0.1.0/24"

	tags = {
		Name = "handson-public-1a"
	}
}

resource "aws_subnet" "public_1c" {
  vpc_id = "${aws_vpc.main.id}"

  availability_zone = "ap-northeast-1c"

  cidr_block        = "10.0.2.0/24"

  tags = {
    Name = "handson-public-1c"
  }
}



# Private Subnets
resource "aws_subnet" "private_1a" {
  vpc_id = "${aws_vpc.main.id}"

  availability_zone = "ap-northeast-1a"
  cidr_block        = "10.0.10.0/24"

  tags = {
    Name = "handson-private-1a"
  }
}

resource "aws_subnet" "private_1c" {
  vpc_id = "${aws_vpc.main.id}"

  availability_zone = "ap-northeast-1c"
  cidr_block        = "10.0.20.0/24"

  tags = {
    Name = "handson-private-1c"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = "${aws_vpc.main.id}"

  tags = {
  Name = "handson"
  }
}

resource "aws_eip" "nat_1a" {
  vpc = true

  tags = {
    Name = "handson-natgw-1a"
  }
}

resource "aws_nat_gateway" "nat_1a" {
  subnet_id = "${aws_subnet.public_1a.id}"
  allocation_id = "${aws_eip.nat_1a.id}"

  tags = {
    Name = "handson-1a"
  }
}

resource "aws_eip" "nat_1c" {
  vpc = true

  tags = {
    Name = "handson-natgw-1c"
  }
}

resource "aws_nat_gateway" "nat_1c" {
  subnet_id = "${aws_subnet.public_1c.id}"
  allocation_id = "${aws_eip.nat_1c.id}"

  tags = {
    Name = "handson-1c"
  }
}

resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.main.id}"

  tags = {
    Name = "handson-public"
  }
}

resource "aws_route" "public" {
  destination_cidr_block = "0.0.0.0/0"
  route_table_id = "${aws_route_table.public.id}"
  gateway_id = "${aws_internet_gateway.main.id}"
}

resource "aws_route_table_association" "public_1a" {
  subnet_id = "${aws_subnet.public_1a.id}"
  route_table_id = "${aws_route_table.public.id}"
}

resource "aws_route_table_association" "public_1c" {
  subnet_id = "${aws_subnet.public_1c.id}"
  route_table_id = "${aws_route_table.public.id}"
}

resource "aws_route_table" "private_1a" {
  vpc_id = "${aws_vpc.main.id}"

  tags = {
    Name = "handson-private-1a"
  }
}

resource "aws_route_table" "private_1c" {
  vpc_id = "${aws_vpc.main.id}"

  tags = {
    Name = "handson-private-1c"
  }
}

resource "aws_route" "private_1a" {
  destination_cidr_block = "0.0.0.0/0"
  route_table_id = "${aws_route_table.private_1a.id}"
  nat_gateway_id = "${aws_nat_gateway.nat_1a.id}"
}

resource "aws_route" "private_1c" {
  destination_cidr_block = "0.0.0.0/0"
  route_table_id = "${aws_route_table.private_1c.id}"
  nat_gateway_id = "${aws_nat_gateway.nat_1c.id}"
}

resource "aws_route_table_association" "private_1a" {
  subnet_id = "${aws_subnet.private_1a.id}"
  route_table_id = "${aws_route_table.private_1a.id}"
}

resource "aws_route_table_association" "private_1c" {
  subnet_id = "${aws_subnet.private_1c.id}"
  route_table_id = "${aws_route_table.private_1c.id}"
}

