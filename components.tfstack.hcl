component "vpc" {
  source = "./vpc"
  inputs = {
  }
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
  }
  providers = {
    aws     = provider.aws.config
  }
}
