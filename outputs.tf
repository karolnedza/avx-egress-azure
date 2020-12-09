output "created_vpc_subnet" {
 value = aviatrix_vpc.aviatrix_vpc_vnet.vpc_id
 }


output "created_private_subnets" {
 value = aviatrix_vpc.aviatrix_vpc_vnet.private_subnets[*].cidr
 }

output "created_public_subnets" {
 value = aviatrix_vpc.aviatrix_vpc_vnet.public_subnets[*].cidr
 }

output "blocked_sites" {
value = aviatrix_fqdn.fqdn_egress.domain_names[*].fqdn
}
