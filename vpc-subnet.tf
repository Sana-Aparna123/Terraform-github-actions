#Vpc creation 1
resource "aws_vpc" "vpc1" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true

  tags = {
    Name = var.vpc_name
  }
}

#Subnet creation 1
resource "aws_subnet" "public-subnet-1" {
  vpc_id                  = aws_vpc.vpc1.id
  cidr_block              = var.subnet1_cidr_block
  availability_zone       = var.subnet1_availabity_zone
  map_public_ip_on_launch = true


  tags = {
    Name = var.subnet1_name
  }
}

#Subnet  creation 2
resource "aws_subnet" "public-subnet-2" {
  vpc_id                  = aws_vpc.vpc1.id
  cidr_block              = var.subnet2_cidr_block
  availability_zone       = var.subnet2_availabity_zone
  map_public_ip_on_launch = true


  tags = {
    Name = var.subnet2_name
  }
  depends_on = [aws_subnet.public-subnet-1]
}

#Subnet  creation 3
resource "aws_subnet" "public-subnet-3" {
  vpc_id                  = aws_vpc.vpc1.id
  cidr_block              = var.subnet3_cidr_block
  availability_zone       = var.subnet3_availabity_zone
  map_public_ip_on_launch = true


  tags = {
    Name = var.subnet3_name
  }
  depends_on = [aws_subnet.public-subnet-2]
}

#Internet gateway
resource "aws_internet_gateway" "vpc1-igw" {
  vpc_id = aws_vpc.vpc1.id

  tags = {
    Name = var.vpc1_internet_gw
  }
}


#Route table creation
resource "aws_route_table" "vpc1-public-route-table" {
  vpc_id = aws_vpc.vpc1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vpc1-igw.id
  }

  #   route {
  #     ipv6_cidr_block        = "::/0"
  #     egress_only_gateway_id = aws_egress_only_internet_gateway.foo.id
  #   }

  tags = {
    Name = "vpc1-public-route-table"
  }
}

#Route table association for public-subnet-1
resource "aws_route_table_association" "vpc1-subnet1-association" {
  subnet_id      = aws_subnet.public-subnet-1.id
  route_table_id = aws_route_table.vpc1-public-route-table.id
}

#Route table association for public-subnet-2
resource "aws_route_table_association" "vpc1-subnet2-association" {
  subnet_id      = aws_subnet.public-subnet-2.id
  route_table_id = aws_route_table.vpc1-public-route-table.id
}

#Route table association for public-subnet-2
resource "aws_route_table_association" "vpc1-subnet3-association" {
  subnet_id      = aws_subnet.public-subnet-3.id
  route_table_id = aws_route_table.vpc1-public-route-table.id
}



