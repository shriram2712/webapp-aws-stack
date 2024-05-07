component "vpc" {
  source = "./vpc"
  providers = {
    aws    = provider.aws.config
  }
}

component "ec2" {
  source = "./ec2"
  inputs = {
    vpc_id                           = component.vpc.vpc_id
    subnet_id                        = component.vpc.subnet_id
    map_public_ip_on_launch          = component.vpc.map_public_ip_on_launch
    vpc_dedicated_security_group_id  = component.vpc.vpc_dedicated_security_group_id
    user_data  = var.user_data
  }
  providers = {
    aws     = provider.aws.config
  }
}
