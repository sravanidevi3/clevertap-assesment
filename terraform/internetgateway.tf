resource "aws_internet_gateway" "clevertap-ig" {
    vpc_id = "${aws_vpc.vpc-clevertap.id}"
    tags = {
      "Name" = "MYInternetGateway"
    }
  }

  resource "aws_route_table" "routetable-clevertap" {
      vpc_id = "${aws_vpc.vpc-clevertap.id}"

      route {
          cidr_block = "0.0.0.0/0"
          gateway_id = "${aws_internet_gateway.clevertap-ig.id}"
       }
      tags = {
        Name = "routetable-clvrtap"
      }
  }

  resource "aws_route_table_association" "routetable-ass-clevertap" {
      subnet_id = aws_subnet.subnet-clevertap-1.id
      route_table_id = "${aws_route_table.routetable-clevertap.id}"  
  }