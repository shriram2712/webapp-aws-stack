data "aws_availability_zones" "ad" {
  state = "available"
  filter {
    name   = "region-name"
    values =[var.aws_region]
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

#data "template_file" "user_data" {
#  template = "${file("${path.module}/user_data.tpl")}"
#  vars = {
#    THEME   = "${var.theme}"
#    WIDTH   = "${var.width}"
#    HEIGHT  = "${var.height}"
#    PREFIX  = "${var.prefix}"
#  }
#}

resource "aws_instance" "inst" {
  ami                          = data.aws_ami.ubuntu.id
  instance_type                = var.instance_type
  associate_public_ip_address  = var.map_public_ip_on_launch
  subnet_id                    = var.subnet_id
#  user_data                    = filebase64("${path.module}/${var.user_data}")
#  user_data                    = "${data.template_file.user_data.rendered}"
  user_data                    = templatefile("${path.module}/user_data.tfpl", { THEME = "${var.theme}", WIDTH = "${var.width}", HEIGHT = "${var.height}", PREFIX = "${var.prefix}"})
  vpc_security_group_ids       = [ var.vpc_dedicated_security_group_id ]  
  metadata_options {
      http_endpoint               = "enabled"
      http_put_response_hop_limit = 1
      http_tokens                 = "optional"
  }
  root_block_device {
      delete_on_termination = true
      encrypted             = false
      iops                  = 100
      volume_size           = 10
  }
  timeouts {}
}

resource "aws_ebs_volume" "vol" {
  count = var.ebs_volume_enabled == true ? 1 : 0
  availability_zone = data.aws_availability_zones.ad.names[0]
  size              = var.ebs_volume_size
}

resource "aws_volume_attachment" "vol_attach" {
  count = var.ebs_volume_enabled == true ? 1 : 0
  device_name = var.ebs_device_name[count.index]
  volume_id   = aws_ebs_volume.vol.*.id[count.index]
  instance_id = join("", aws_instance.inst.*.id)
}
