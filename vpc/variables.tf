variable "aws_region" {
  description = "The AWS Region for the VPC to be created in."
  type = string
}

variable "vpc_name" {
  description = "The name for the VPC."
  default = "webapp-aws-vpc"
}

variable "vpc_cidr" {
  description = "The CIDR block to be used by the VPC."
  default = "192.168.0.0/16"
}

variable "subnet_name"{
  description = "The name for the VPC subnet."
  default = "webapp-aws-sub" 
}
  
variable "subnet_cidr"{
  description = "The CIDR block for the VPC subnet."
  default = "192.168.10.0/24"
}

variable "map_public_ip_on_launch" { 
  description = "Indicate if instances launched into the VPC's Subnet will be assigned a public IP address."
  default = true   
}  

variable "igw_name"{
  description = "The name for the VPC internet gateway."
  default = "webapp-aws-igw" 
}

variable "rt_name"{
  description = "The Routing Table for the VPC."
  default = "webapp-aws-rt" 
}

variable "sg_name"{
  description = "The Security Group for the VPC."
  default = "webapp-aws-sg" 
}  