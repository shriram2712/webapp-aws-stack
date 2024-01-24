data "aws_availability_zones" "available" {
  state = "available"
}

# PROJECT DATA SOURCE
data "aws_availability_zones" "ad" {
  state = "available"
  filter {
    name   = "region-name"
    values =[var.aws_region]
  }
}


# VPC
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    "Name" = var.vpc_name
  }
}


# SUBNET
resource "aws_subnet" "sub" {
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = data.aws_availability_zones.ad.names[0]
  cidr_block              = var.subnet_cidr
  map_public_ip_on_launch = var.map_public_ip_on_launch
  tags = {
    "Name" = var.subnet_name
  }
  timeouts {}
}

# INTERNET GATEWAY
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags   = {
    "Name" = var.igw_name
  }
}

# ROUTE TABLE
resource "aws_route_table" "rt" {
  vpc_id  = aws_vpc.vpc.id
  route  {
    cidr_block   = "0.0.0.0/0"
    gateway_id   = aws_internet_gateway.igw.id
  }
  tags = {
    "Name" = var.rt_name
  }
}

resource "aws_route_table_association" "rt_sub" {
  route_table_id = aws_route_table.rt.id
  subnet_id      = aws_subnet.sub.id
}

# SECURITY GROUP
resource "aws_security_group" "sg" {
  name        = var.sg_name
  vpc_id      = aws_vpc.vpc.id
  description = "SSH ,HTTP, and HTTPS"
  egress {
    cidr_blocks = [
      "0.0.0.0/0",
    ]
    description      = "default egress"
    from_port        = 0
    protocol         = "-1"
    to_port          = 0
    self             = false
  }  
  ingress = [ 
    {
    cidr_blocks      = [
      "0.0.0.0/0",
    ]
    description      = "Inbound HTTP access "
    from_port        = 80
    protocol         = "tcp"
    to_port          = 80
    prefix_list_ids  = null  # (Optional) List of prefix list IDs.
    ipv6_cidr_blocks = null  # (Optional) List of IPv6 CIDR blocks.
    security_groups  = null   # (Optional) List of security group Group Names if using EC2-Classic, or Group IDs if using a VPC.
    self             = false # (Optional, default false) If true, the security group itself will be added as a source to this ingress rule.
    },
    {
    cidr_blocks      = [
      "0.0.0.0/0",
    ]
    description      = "Inbound HTTPS access "
    from_port        = 443
    protocol         = "tcp"
    to_port          = 443
    prefix_list_ids  = null  # (Optional) List of prefix list IDs.
    ipv6_cidr_blocks = null  # (Optional) List of IPv6 CIDR blocks.
    security_groups  = null   # (Optional) List of security group Group Names if using EC2-Classic, or Group IDs if using a VPC.
    self             = false # (Optional, default false) If true, the security group itself will be added as a source to this ingress rule.  
    },
    {
    cidr_blocks      = [
      "0.0.0.0/0",
    ]
    description      = "Inbound SSH access"
    from_port        = 22
    protocol         = "tcp"
    security_groups  = []
    to_port          = 22
     prefix_list_ids  = null  # (Optional) List of prefix list IDs.
    ipv6_cidr_blocks = null  # (Optional) List of IPv6 CIDR blocks.
    security_groups  = null   # (Optional) List of security group Group Names if using EC2-Classic, or Group IDs if using a VPC.
    self             = false # (Optional, default false) If true, the security group itself will be added as a source to this ingress rule.        
    },
    {
    cidr_blocks      = [
      "0.0.0.0/0",
    ]
    description      = "Inbound RDP access "
    from_port        = 3389
    protocol         = "tcp"
    to_port          = 3389
    prefix_list_ids  = null  # (Optional) List of prefix list IDs.
    ipv6_cidr_blocks = null  # (Optional) List of IPv6 CIDR blocks.
    security_groups  = null   # (Optional) List of security group Group Names if using EC2-Classic, or Group IDs if using a VPC.
    self             = false # (Optional, default false) If true, the security group itself will be added as a source to this ingress rule.
    },
  ]
  tags = {
  Name = var.sg_name
  }
  timeouts {}
}

