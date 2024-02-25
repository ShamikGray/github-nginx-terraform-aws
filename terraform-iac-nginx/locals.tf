#locals {
  #ip_address    = jsondecode(data.external.vend_ip.result)["ip_address"]
  #subnet_size   = jsondecode(data.external.vend_ip.result)["subnet_size"]
 # subnet_prefix = cidrsubnet(local.ip_address, local.subnet_size, 0)
#}


locals {
  private_key_filename = "${var.prefix}-ssh-key"
}
