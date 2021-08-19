data "aws_subnet_ids" "subnets" {
  vpc_id = var.vpc_id
}
resource "aws_internet_gateway" "clevertap-ig" {
    vpc_id = var.vpc_id
    tags = {
      "Name" = "MYInternetGateway"
    }
  }

  resource "aws_route_table" "routetable-clevertap" {
      vpc_id = var.vpc_id

      route {
          cidr_block = "0.0.0.0/0"
          gateway_id = "${aws_internet_gateway.clevertap-ig.id}"
       }
      tags = {
        Name = "routetable-clvrtap"
      }
  }

  resource "aws_route_table_association" "routetable-ass-clevertap" {
      subnet_id = data.aws_subnet_ids.subnets.ids
      route_table_id = "${aws_route_table.routetable-clevertap.id}"  
  }
