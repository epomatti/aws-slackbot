data "aws_region" "current" {}

locals {
  region = data.aws_region.current.name
  az1    = "${local.region}a"
}

resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  # Enable DNS hostnames 
  enable_dns_hostnames = true

  tags = {
    Name = "vpc-slackbot"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "ig-slackbot"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "rt-slackbot-public"
  }
}

resource "aws_subnet" "public1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = local.az1

  map_public_ip_on_launch = false

  tags = {
    Name = "subnet-slackbot-pub1"
  }
}

resource "aws_route_table_association" "public1" {
  subnet_id      = aws_subnet.public1.id
  route_table_id = aws_route_table.public.id
}
