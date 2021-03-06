variable "vnet_vpc_address_space" {}   
variable "cloud_region" {}
variable "fqdn_domains" {} # list of domains example:  facebook.com, *.tiktok.com, www.amazon.com
variable "vpc_name" {default = "default-name"}
variable "ctrl_password" {}
variable "vcs_repository" {default = "placeholder"}
variable "ctrl_ip" {}
