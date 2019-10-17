
# Outputs file
output "app_url" {
  value = "http://${azurerm_public_ip.app-pip.fqdn}"
}
output "app_fqdn" {
  value = "${azurerm_public_ip.app-pip.fqdn}"
}

output "network_interface_id" {
  value = "${azurerm_network_interface.app-nic.id}"
}
