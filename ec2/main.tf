# DATA

data "aws_availability_zones" "ad" {
  state = "available"
  filter {
    name   = "region-name"
    values =[var.aws_region]
  }
}


# INSTANCE

resource "aws_instance" "inst" {
  ami                          = var.instance_ami_id
  disable_api_termination      = false
  ebs_optimized                = false
  get_password_data            = false
  hibernation                  = false
  instance_type                = var.instance_type
  associate_public_ip_address  = var.map_public_ip_on_launch
  monitoring                   = false
  secondary_private_ips        = []
  security_groups              = []
  source_dest_check            = true
  subnet_id                    = var.subnet_id
  #user_data                    = var.user_data
  user_data                    = filebase64("${path.module}/var.user_data")
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

# VOLUME
 
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
