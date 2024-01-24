# AWS REGION

variable "aws_region" {
    default = "us-east-1"
}

# VPC INFO

variable "vpc_name" {
  default = "tf-cloud-demo-oe-vpc"
}

variable "vpc_cidr" {
  default = "192.168.0.0/16"
}

# SUBNET INFO

variable "subnet_name"{
  default = "tf-cloud-demo-oe-sub" 
}
  
variable "subnet_cidr"{
  default = "192.168.10.0/24"
}

variable "map_public_ip_on_launch" { 
  description = "Indicate if instances launched into the VPC's Subnet will be assigned a public IP address . "
  default = true   
}  

# IGW INFO

variable "igw_name"{
  default = "tf-cloud-demo-oe-igw" 
}

# ROUTE TABLE INFO

variable "rt_name"{
  default = "tf-cloud-demo-oe-rt" 
}

# SG INFO

variable "sg_name"{
  default = "tf-cloud-demo-oe-sg" 
}  