variable "aws_region" {
    default = "us-east-1"
}

variable "vpc_id" {
  description = "The VPC ID created by the previous component"
  type = string
}

variable "subnet_id" {
  description = "The Subnet ID created by the previous component"
  type = string
}

variable "map_public_ip_on_launch" {
  description = "The Public IP created by the previous component"
  type = string
}

variable "vpc_dedicated_security_group_id" {
  description = "The VPC Dedicated SG ID created by the previous component"
  type = string
}

variable "instance_type" {
  default = "t2.micro"
}

variable "instance_ami_id" {
  default = "ami-0c4f7023847b90238"
}

variable "user_data" {
  default = "<<-EOT
    #!/bin/sh
    sudo apt-get update
    sudo apt --assume-yes install nginx
    sudo apt --assume-yes install git
    sudo ufw allow 'Nginx HTTP'
    #sudo systemctl start nginx
    sudo systemctl enable nginx
    sudo systemctl status nginx
    sudo git clone https://github.com/omeeomi/tf-cloud-demo-website /tmp/tf-cloud-demo-website
    sudo mkdir -p /var/www/html/
    sudo cp /tmp/tf-cloud-demo-website/index.html /var/www/html/index.html
    EOT" 
}

variable "ebs_volume_enabled" {
  type        = bool
  default     = true
  description = "Flag to control the ebs creation."
} 

variable "ebs_volume_size" {
 type        = number
 default     = 10
 description = "Size of the ebs volume in gigabytes."
}

variable "ebs_device_name" {
  type        = list(string)
  default     = ["/dev/xvdb", "/dev/xvdc", "/dev/xvdd", "/dev/xvde", "/dev/xvdf", "/dev/xvdg", "/dev/xvdh", "/dev/xvdi", "/dev/xvdj", "/dev/xvdk", "/dev/xvdl", "/dev/xvdm", "/dev/xvdn", "/dev/xvdo", "/dev/xvdp", "/dev/xvdq", "/dev/xvdr", "/dev/xvds", "/dev/xvdt", "/dev/xvdu", "/dev/xvdv", "/dev/xvdw", "/dev/xvdx", "/dev/xvdy", "/dev/xvdz"]
  description = "Name of the EBS device to mount."
}

variable "vol_name" {
  type        = string
  default     = "vol_0"
  description = "The name of the EBS"
}