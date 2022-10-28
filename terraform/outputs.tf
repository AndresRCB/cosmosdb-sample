output "jumpbox_login_command" {
  value       = "az network bastion ssh --name ${azurerm_bastion_host.main.name} --resource-group ${azurerm_resource_group.main.name} --target-resource-id ${azurerm_virtual_machine.jumpbox.id} --auth-type ssh-key --username ${var.jumpbox_admin_name} --ssh-key ${var.ssh_key_file}"
  description = "Command to connect to the jumpbox VM"
}

output "managed_identity_client_id" {
  value = azurerm_user_assigned_identity.main.client_id
  description = "Client ID of the user-assigned managed identity needed to connect to Cosmos DB"
}

output "resource_group_name" {
  value = azurerm_resource_group.main.name
  description = "Name of the resource group containing all resources"
}

output "cosmos_db_account_name" {
  value = module.azure_cosmos_db.cosmosdb_id
  description = "Name of the Cosmos DB account"
}

output "cosmos_db_account_endpoint" {
  value = module.azure_cosmos_db.cosmosdb_endpoint
  description = "Endpoint URI needed to connect to the Cosmos DB account"
}
