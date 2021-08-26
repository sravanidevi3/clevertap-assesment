resource "aws_vpc" "vpc-clevertap" {
    cidr_block = "10.0.0.0/16"
    enable_dns_support = "true"
    enable_dns_hostnames = "true"
       tags = {
         "name" = "vpc-clevertap"
       }
}

resource "aws_subnet" "subnet-clevertap-1" {
    vpc_id = "${aws_vpc.vpc-clevertap.id}"
    cidr_block = "10.0.0.0/16"
    map_public_ip_on_launch = "true"
    availability_zone = "us-east-1a"
     tags = {
       "Name" = "clevertap-us-east-1"
     } 
}
resource "aws_subnet" "subnet-clevertap-2" {
    vpc_id = "${aws_vpc.vpc-clevertap.id}"
    cidr_block = "10.0.0.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "us-east-1b"
     tags = {
       "Name" = "clevertap-us-east-2"
     } 
}
