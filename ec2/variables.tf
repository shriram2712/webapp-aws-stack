variable "aws_region" {
  description = "The AWS Region the Web App is deployed in."
  default = "us-east-1"
}

variable "vpc_id" {
  description = "The VPC ID created by the previous component."
  type = string
}

variable "subnet_id" {
  description = "The Subnet ID created by the previous component."
  type = string
}

variable "map_public_ip_on_launch" {
  description = "The Public IP created by the previous component."
  type = string
}

variable "vpc_dedicated_security_group_id" {
  description = "The VPC Dedicated SG ID created by the previous component."
  type = string
}

variable "instance_type" {
  default = "t2.micro"
}

variable "user_data" {
  description = "The User Data file to be used for the site."
}

variable "ebs_volume_enabled" {
  description = "Flag to control the ebs creation."
  type        = bool
  default     = true
} 

variable "ebs_volume_size" {
 description = "Size of the ebs volume in gigabytes."
 type        = number
 default     = 10
}

variable "ebs_device_name" {
  description = "Name of the EBS device to mount."
  type        = list(string)
  default     = ["/dev/xvdb", "/dev/xvdc", "/dev/xvdd", "/dev/xvde", "/dev/xvdf", "/dev/xvdg", "/dev/xvdh", "/dev/xvdi", "/dev/xvdj", "/dev/xvdk", "/dev/xvdl", "/dev/xvdm", "/dev/xvdn", "/dev/xvdo", "/dev/xvdp", "/dev/xvdq", "/dev/xvdr", "/dev/xvds", "/dev/xvdt", "/dev/xvdu", "/dev/xvdv", "/dev/xvdw", "/dev/xvdx", "/dev/xvdy", "/dev/xvdz"]
}

variable "vol_name" {
  description = "The name of the EBS volume."
  type        = string
  default     = "vol_0"
}
