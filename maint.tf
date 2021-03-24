#######################################################################
# VPC/Vnet

resource "aviatrix_vpc" "aviatrix_vpc_vnet" {
  cloud_type           =  8
  account_name         = "azure-account" 
  region               =  var.cloud_region
  name                 = "${var.vpc_name}-vpc"
  cidr                 = var.vnet_vpc_address_space
  aviatrix_transit_vpc = false
  aviatrix_firenet_vpc = false
}

####################################################################
# Aviatrix Egress GW

resource "aviatrix_gateway" "avx-egress" {
  cloud_type             =  8
  vpc_reg               =  var.cloud_region
  vpc_id                 = aviatrix_vpc.aviatrix_vpc_vnet.vpc_id
  account_name           =  "azure-account"
  gw_name                = "avx-${var.vpc_name}-gw"
  gw_size                = "Standard_B1ms" 
  single_ip_snat         = true
  subnet           = aviatrix_vpc.aviatrix_vpc_vnet.public_subnets[0].cidr
}

########

resource "aviatrix_fqdn" "fqdn_egress" {
    fqdn_mode = "black"
    fqdn_enabled = true
    fqdn_tag = "fqdn-${var.vpc_name}"

    gw_filter_tag_list {
        gw_name = aviatrix_gateway.avx-egress.gw_name
    }

    dynamic "domain_names" {
        for_each = toset(split(",", var.fqdn_domains))
      content {
        fqdn = trimspace(domain_names.value)
        port = "443"
        proto = "tcp"
        action = "Base Policy"
      }
    }
}
