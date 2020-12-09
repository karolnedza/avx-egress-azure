output "created_vpc_subnet" {
 value = aviatrix_vpc.aviatrix_vpc_vnet.vpc_id
 }

output "created_vpc_subnets" {
 value = aviatrix_vpc.aviatrix_vpc_vnet.subnets[*].cidr
 }
