
# https://www.terraform.io/docs/providers/aws/r/vpc.html
# It is important to look at the documentation so we can review all the possible variables
resource "aws_vpc" "main1" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true

  tags = {
      Name = "Main VPC 1"
  }
}

# ----------------------------------------------------------------------
# INTERPOLATION
# https://www.terraform.io/docs/configuration/expressions.html
# Allows to bring attributes of other resources previously defined.
# When using interpollation, the syntax should follow:
    # TYPE.NAME.ATTRIBUTE - i.e. ${aws_instance.web.id}
    # In new terraform version, the "${}" is no longer needed. You can call directly the variable as it is done below
# ----------------------------------------------------------------------

# SUBNETS
resource "aws_subnet" "subnet1" {
    vpc_id = aws_vpc.main1.id
    cidr_block = "10.0.10.0/24"
    map_public_ip_on_launch = true
    # Parameter for Auto-assign public IPv4 address

    availability_zone = "us-east-1a"

    #I Important to add tags always (recommendation)
    tags = {
        Name = "Subnet 1 en us-east-1a"
    }
}

resource "aws_subnet" "subnet2" {
    vpc_id = aws_vpc.main1.id
    cidr_block = "10.0.20.0/24"
    map_public_ip_on_launch = true
    # Parameter for Auto-assign public IPv4 address

    availability_zone = "us-east-1b"

    #I Important to add tags always (recommendation)
    tags = {
        Name = "Subnet 1 en us-east-1b"
    }
}

resource "aws_subnet" "subnet3" {
    vpc_id = aws_vpc.main1.id
    cidr_block = "10.0.30.0/24"
    map_public_ip_on_launch = true
    # Parameter for Auto-assign public IPv4 address

    availability_zone = "us-east-1c"

    #I Important to add tags always (recommendation)
    tags = {
        Name = "Subnet 1 en us-east-1c"
    }
}

# INTERNET GATEWAY
# Provides a resource to create a VPC Internet Gateway.
# https://www.terraform.io/docs/providers/aws/r/internet_gateway.html
# It has to be defined in a VPC and should be mapped to the route table

resource "aws_internet_gateway" "gw" {
    vpc_id = aws_vpc.main1.id

    tags = {
        Name = "Gateway Main"
    }
}

# ROUTE TABLE
# Provides a resource to create a VPC routing table.
# https://www.terraform.io/docs/providers/aws/r/route_table.html

resource "aws_route_table" "r"{
    vpc_id = aws_vpc.main1.id
    route {
        cidr_block = "0.0.0.0/0"

        # Internet gateway assignation 
        gateway_id = aws_internet_gateway.gw.id 
    }

    tags = {
        Name = "Route table Mainx"
    }
}

# ROUTE TABLE ASSOCIATION
# Provides a resource to create an association between a route table and a subnet or a route table and an 
# internet gateway or virtual private gateway.
# https://www.terraform.io/docs/providers/aws/r/route_table_association.html

resource "aws_route_table_association" "table_subnet1"{
    subnet_id = aws_subnet.subnet1.id
    route_table_id = aws_route_table.r.id
}

resource "aws_route_table_association" "table_subnet2"{
    subnet_id = aws_subnet.subnet2.id
    route_table_id = aws_route_table.r.id
}

resource "aws_route_table_association" "table_subnet3"{
    subnet_id = aws_subnet.subnet3.id
    route_table_id = aws_route_table.r.id
}

# If more subnets are added, it is possible to associate them by copy the above code and changing accordingly
# however, there is a better way of doing it.
# It will be done later
