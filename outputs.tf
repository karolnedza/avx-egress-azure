output "created_vpc_subnet" {
 value = aviatrix_vpc.aviatrix_vpc_vnet.vpc_id
 }


output "created_vpc_private_subnets" {
 value = aviatrix_vpc.aviatrix_vpc_vnet.private_subnets[*].cidr
 }

output "created_vpc_public_subnets" {
 value = aviatrix_vpc.aviatrix_vpc_vnet.public_subnets[*].cidr
 }
