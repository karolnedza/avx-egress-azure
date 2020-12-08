#######################################################################
# VPC/Vnet
#
locals {
  subnet_count = length(aviatrix_vpc.aviatrix_vpc_vnet.subnets[*].cidr)/2
}

resource "aviatrix_vpc" "aviatrix_vpc_vnet" {
  cloud_type           =  1
  account_name         = "aws-account" 
  region               =  var.cloud_region
  name                 = "${var.vpc_name}-vpc"
  cidr                 = var.vnet_vpc_address_space
  aviatrix_transit_vpc = false
  aviatrix_firenet_vpc = false
}

####################################################################
# Aviatrix Egress GW

resource "aviatrix_gateway" "avx-egress" {
  cloud_type             =  1 
  vpc_reg               =  var.cloud_region
  vpc_id                 = aviatrix_vpc.aviatrix_vpc_vnet.vpc_id
  account_name           =  "aws-account"
  gw_name                = "avx-${var.vpc_name}-gw"
  gw_size                = "t2.medium" 
  subnet           = aviatrix_vpc.aviatrix_vpc_vnet.subnets[local.subnet_count].cidr
}

########

resource "aviatrix_fqdn" "fqdn_egress" {
    fqdn_mode = "white"
    fqdn_enabled = true
    fqdn_tag = "fqds-${var.vpc_name}"

    gw_filter_tag_list {
        gw_name = aviatrix_gateway.avx-egress.gw_name
    }

    dynamic "domain_names" {
        for_each = toset(split(",", var.fqdn_domains))
      content {
        fqdn = trimspace(domain_names.value)
        port = "443"
        proto = "tcp"
        action = "Deny"
      }
    }
}
