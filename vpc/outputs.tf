# VPC OUTPUT
output "vpc_id" {
  description = "id of created VPC."
  value       = aws_vpc.vpc.vpc_id
}

# SUBNET OUTPUT   
output "subnet_id" {
  description = "id of created VPC."
  value       = aws_subnet.sub.id
}

output "map_public_ip_on_launch" {
  description = "Indicate if instances launched into the VPC's Subnet will be assigned a public IP address . "
  value       = aws_subnet.sub.map_public_ip_on_launch
}

# SECURITY GROUP INFO
output "vpc_dedicated_security_group_id" {
  description = "Security group id."
  value       = aws_security_group.sg.id
}
