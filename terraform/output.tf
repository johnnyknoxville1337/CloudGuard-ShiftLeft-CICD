output "External_Load_Balancer_Public_IP_Address" {
  value =  azurerm_public_ip.albvip1.ip_address
}

output "JumpServer_Public_IP_Address" {
  value =  azurerm_public_ip.jumphostvip.ip_address
}
