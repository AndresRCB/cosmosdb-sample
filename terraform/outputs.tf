output "jumpbox-login-command" {
  value       = "az network bastion ssh --name ${azurerm_bastion_host.main.name} --resource-group ${azurerm_resource_group.main.name} --target-resource-id ${azurerm_virtual_machine.jumpbox.id} --auth-type ssh-key --username ${var.jumpbox_admin_name} --ssh-key ${var.ssh_key_file}"
  description = "Command to connect to the jumpbox VM"
}
