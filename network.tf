#---------------------------------------------------
# Create VPC
#---------------------------------------------------
resource "aws_vpc" "mydemo2" {
    cidr_block = var.vpc_cidr
       tags = {
        Name = "${var.project}-vpc"
    }
}
#---------------------------------------------------
# Create GateWay for  VPC 
#---------------------------------------------------
resource "aws_internet_gateway" "igateway" {
    vpc_id = aws_vpc.mydemo2.id
    tags = {
        Name = "${var.project}-igateway"
    }
}
#---------------------------------------------------
# Create Public Subnet A
#---------------------------------------------------
resource "aws_subnet" "public-subnetA" {
        vpc_id = aws_vpc.mydemo2.id
    cidr_block = "10.0.11.0/24"
    availability_zone = "ca-central-1a"
    map_public_ip_on_launch = true
  tags = {
    Name = "${var.project}-public-subnet-A"
  }

}
#---------------------------------------------------
# Create Public Subnet B
#---------------------------------------------------
resource "aws_subnet" "public-subnetB" {
        vpc_id = aws_vpc.mydemo2.id
    cidr_block = "10.0.21.0/24"
    availability_zone = "ca-central-1b"
    map_public_ip_on_launch = true
  tags = {
    Name = "${var.project}-public-subnet-B"
  }
 
}
#---------------------------------------------------
# Create Private Subnet A
#---------------------------------------------------
resource "aws_subnet" "private-subnetA" {
  vpc_id            = aws_vpc.mydemo2.id
  cidr_block        = "10.0.12.0/24"
  availability_zone = "ca-central-1a"
    tags = {
    Name = "${var.project}-private-subnet-A"
  }
}
#---------------------------------------------------
# Create Private Subnet B
#---------------------------------------------------
resource "aws_subnet" "private-subnetB" {
  vpc_id            = aws_vpc.mydemo2.id
  cidr_block        = "10.0.22.0/24"
  availability_zone = "ca-central-1b"
  tags = {
    Name = "${var.project}-private-subnet-B"
  }
}
#---------------------------------------------------
# Create  Elastic IP for NAT Gateways (natA  and natB)
#---------------------------------------------------
resource "aws_eip" "eipA" {
   vpc   = true
  tags = {
    Name = "${var.project}-eipA"
  }
}
resource "aws_eip" "eipB" {
   vpc   = true
  tags = {
    Name = "${var.project}-eipB"
  }
}
#---------------------------------------------------
# Create NAT Gateways for Elastic IP
#---------------------------------------------------

resource "aws_nat_gateway" "natA" {
  allocation_id = aws_eip.eipA.id
  subnet_id     = aws_subnet.public-subnetA.id
    tags = {
    Name = "${var.project}-natA"
  }
}

resource "aws_nat_gateway" "natB" {
  allocation_id = aws_eip.eipB.id
  subnet_id     = aws_subnet.public-subnetB.id
    tags = {
    Name = "${var.project}-natB"
  }
}

#---------------------------------------------------
# Create Routing Table in Subnets through the igateway
#---------------------------------------------------
resource "aws_route_table" "routetable-public-subnets" {
vpc_id = aws_vpc.mydemo2.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igateway.id
  }
  tags = {
    Name = "${var.project}-routetable-public-subnets"
  }
}
#---------------------------------------------------
# Create Route Table Association Public
#---------------------------------------------------

resource "aws_route_table_association" "public-routesA" {
    subnet_id      = aws_subnet.public-subnetA.id
    route_table_id = aws_route_table.routetable-public-subnets.id
}
resource "aws_route_table_association" "public-routesB" {
    subnet_id      = aws_subnet.public-subnetB.id
    route_table_id = aws_route_table.routetable-public-subnets.id
}

#---------------------------------------------------
# Create a new route table for the private subnets
#---------------------------------------------------
resource "aws_route_table" "routetable-privateA" {
vpc_id = aws_vpc.mydemo2.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.natA.id
  }
  tags = {
    Name = "${var.project}-routetable-privateA"
  }
}

resource "aws_route_table" "routetable-privateB" {
vpc_id = aws_vpc.mydemo2.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.natB.id
  }
  tags = {
    Name = "${var.project}-routetable-privateB"
  }
}

#---------------------------------------------------
# Create Route Table Association Private
#---------------------------------------------------

resource "aws_route_table_association" "privat-routesA" {
    subnet_id      = aws_subnet.private-subnetA.id
    route_table_id = aws_route_table.routetable-privateA.id
}
resource "aws_route_table_association" "private-routesB" {
    subnet_id      = aws_subnet.private-subnetB.id
    route_table_id = aws_route_table.routetable-privateB.id
}
