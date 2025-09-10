resource "aws_vpc" "vpc1" {
    cidr_block = "10.0.0.0/16"
    instance_tenancy = "default"
    tags = {
        Name = "Project_Vpc"
    }
}

# subnet creation

resource "aws_subnet" "pub1" {

    vpc_id = aws_vpc.vpc1.id
    cidr_block = "10.0.0.0/18"
    availability_zone = "ap-south-1a"
    tags = {
      Name = "Public_sub1"
    }
}

resource "aws_subnet" "pub2" {
    vpc_id = aws_vpc.vpc1.id
    cidr_block = "10.0.64.0/18"
    availability_zone = "ap-south-1b"
    tags = {
      Name = "Public_sub2"
    }
}

resource "aws_subnet" "prv1" {
    vpc_id = aws_vpc.vpc1.id
    cidr_block = "10.0.128.0/18"
    availability_zone = "ap-south-1a"
    tags = {
      Name = "Private_sub1"
    }
}

resource "aws_subnet" "prv2" {
  vpc_id = aws_vpc.vpc1.id
  cidr_block = "10.0.192.0/18"
  availability_zone = "ap-south-1b"
  tags = {
    Name = "Private_sub2"
  }
}

#Internet Gateway

resource "aws_internet_gateway" "IG" {
    vpc_id = aws_vpc.vpc1.id
    tags = {
      Name = "IG1"
    }
  
}

#Elastic Ip and Nat Gateway

resource "aws_eip" "eip" {
    domain = "vpc"
    tags = {
      Name = "Elastic-ip"
    }
  
}

resource "aws_nat_gateway" "nat" {
    allocation_id = aws_eip.eip.id
    subnet_id = aws_subnet.pub1.id
    tags = {
      Name = "NAT"
    }
  
}

#route tables for public subnets

resource "aws_route_table" "table1" {
  vpc_id = aws_vpc.vpc1.id
  tags = {
    Name = "Public_route_table"
  }
}

resource "aws_route_table_association" "association1" {
    subnet_id = aws_subnet.pub1.id
    route_table_id = aws_route_table.table1.id
  
}

resource "aws_route_table_association" "association2" {
  subnet_id = aws_subnet.pub2.id
  route_table_id = aws_route_table.table1.id
}


resource "aws_route" "public-routes" {
  route_table_id = aws_route_table.table1.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.IG.id
}

#route tables for private subnets
resource "aws_route_table" "table2" {
  vpc_id = aws_vpc.vpc1.id
  tags = {
    Name = "Private_route_table"
  }
}

resource "aws_route_table_association" "asso1" {
  subnet_id = aws_subnet.prv1.id
  route_table_id = aws_route_table.table2.id
}

resource "aws_route_table_association" "ass2" {
    subnet_id = aws_subnet.prv2.id
    route_table_id = aws_route_table.table2.id
}

resource "aws_route" "private-routes" {
    route_table_id = aws_route_table.table2.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat.id
  
}