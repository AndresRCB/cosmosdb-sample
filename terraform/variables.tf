variable "resource_group_name" {
  type        = string
  description = "name for the resource group"
}

variable "ssh_key_file" {
  type        = string
  description = "Location of the private SSH key in the local file system"
}

variable "location" {
  type        = string
  description = "location for the resource group"
  default     = "eastus"
}

variable "vnet_name" {
  type        = string
  description = "Name of the virtual network where all resources will be"
  default     = "cosmosdb-vnet"
}

variable "vnet_cidr" {
  type        = string
  description = "CIDR range for the virtual network"
  default     = "172.16.0.0/16"
}

variable "subnet_name" {
  type        = string
  description = "Name of the subnet where all resources will be"
  default     = "cosmosdb-subnet"
}

variable "subnet_cidr" {
  type        = string
  description = "CIDR range for the main subnet"
  default     = "172.16.0.0/20"
}

variable "jumpbox_user_identity" {
  type        = string
  description = "Name of the identity assigned to the jump box VM"
  default     = "jumpbox_user"
}

variable "jumpbox_name" {
  type        = string
  description = "Name of the jump box VM"
  default     = "jumpbox"
}

variable "jumpbox_admin_name" {
  type        = string
  description = "Name of the admin username in the jump box"
  default     = "azureuser"
}

variable "jumpbox_size" {
  type        = string
  description = "Size of the jump box VM"
  default     = "Standard_D2s_v3"
}

variable "bastion_public_ip_name" {
  type        = string
  description = "Name of the public IP address for Azure Bastion"
  default     = "bastion-ip"
}

variable "bastion_subnet_cidr" {
  type        = string
  description = "CIDR range for the cluster subnet"
  default     = "172.16.255.0/24"
}

variable "bastion_name" {
  type        = string
  description = "Name of the Azure Bastion that connects to the cluster's VNET"
  default     = "main-bastion"
}

variable "private_dns_vnet_link_name" {
  type        = string
  description = "Private DNS Zone Link Name"
  default     = "sqlapi_zone_link"
}

variable "dns_zone_group_name" {
  type        = string
  description = "Zone Group Name for PE"
  default     = "pe_zone_group"
}

variable "pe_name" {
  type        = string
  description = "Private Endpoint Name"
  default     = "cosmosdb_pe"
}

variable "pe_connection_name" {
  type        = string
  description = "Private Endpoint Connection Name"
  default     = "pe_connection"
}

variable "cosmosdb_account_name" {
  type        = string
  description = "Cosmos db account name"
  default     = "cosmosdb-account"
}

variable "cosmosdb_sqldb_name" {
  type        = string
  description = "Name for SQL DB inside Cosmos DB Account"
  default     = "cosmosdb-sqldb"
}

variable "sql_container_name" {
  type        = string
  description = "SQL API container name."
  default     = "cosmosdb-container"
}

variable "throughput" {
  type        = number
  description = "Cosmos DB database throughput"
  default     = 400
  validation {
    condition     = var.throughput >= 400 && var.throughput <= 1000000
    error_message = "Cosmos db manual throughput should be equal to or greater than 400 and less than or equal to 1000000."
  }
  validation {
    condition     = var.throughput % 100 == 0
    error_message = "Cosmos db throughput should be in increments of 100."
  }
}
