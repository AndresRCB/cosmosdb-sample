# Cosmos DB Sample

Creating a private Cosmos DB account and accessing it using managed identities.

## Prerequisites
- Access to Azure (account and network access)
- A console (bash or zsh in this case) where you have admin rights
- An Azure subscription
- [Terraform CLI](https://www.terraform.io/downloads)

## Setting up the environment
Once you have an [Azure account](https://azure.microsoft.com/en-us/free/search/), an Azure subscription, and can sign into the [Azure Portal](https://portal.azure.com/), open a console session.

In order to authenticate to Azure from terraform, you'll need to install the Azure CLI. You can install Azure CLI by running the command below in Linux or MacOS, or you can look for [alternatives here](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli).
```sh
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
```

Then, log into your Azure account by running
```sh
az login
```

Once you are in your account, select the subscription with which you want to work.
```sh
## Show available subscriptions
az account show -o table
## Set the subscription you want to use
# az account set -n YOUR_SUBSCRIPTION_NAME
```

Once Azure CLI is authenticated, the Terraform CLI tool will use your azure credentials to manage infrastructure. Now you are ready to start deploying infrastructure with Terraform.

## Creating the Infrastruture
In this section, we will create an SSH key and instruct terraform to create our infrastructure.

### Creating an SSH key
First, we need to create an SSH key to access the Linux jump box VM that Terraform will create for us. While we will add instructions on how to create said key (for MacOS and Linux), you can use an existing SSH key if you prefer (keeing in mind that Azure only supports RSA SSH2 key signatures of at least 2048 bits in length).

Run the following command in your console (replace the email address with your own).
```sh
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
```

We can leave the default values that `ssh-keygen` prompts (key location and no passphrase); however, we need to keep the key location at hand (`~/.ssh/id_rsa` by default) because we will need it as an input in our terraform commands/script.

### Executing the terraform scripts
First, clone this repository and go into the `terraform/` folder.

```sh
# First navigate to the location where you want this repo.
# Then, run:
git clone https://github.com/andresrcb/cosmosdb-sample.git
cd cosmosdb-sample/terraform
```

Now that we can execute the terraform commands needed to bring out the Azure infrastructure, we just need to add the necessary parameters to the code via the command line or with a `.tfvars` file. This repository includes a [sample file](/terraform/terraform.tfvars.sample) that can be copied a starting point.

Assuming that our SSH key is at `~/.ssh/id_rsa`, we can create a `terraform.tfvars` file to avoid having to pass them in the CLI, setting them as environment variables or being prompted by them when running terraform plan/apply (to override other values, check out the sample file). NOTE that the account name for your cosmosdb account must be globally unique.

```sh
resource_group_name = "cosmosdb-sample-rg"
ssh_key_file = "~/.ssh/id_rsa"
cosmosdb_account_name   = "cosmosdb-sample-$ANYRANDOMNAME-account"
```

Now you can plan and apply your infrastructure changes by executing `terraform plan` and`terraform apply` commands.

```sh
terraform plan
# Check your plan and feel free to use it in the next command (we're just running apply as-is)
terraform apply
```

### Connecting using a jump box and Azure Bastion
An Azure Bastion and a Jumpbox are part of the terraform files in this section. The SSH key generated at the beginning of this guide was used for the jump box VM, so the command below should establish a connection to the jump box VM.

```sh
# az network bastion ssh \
#                 --name $BASTION_HOST_NAME \
#                 --resource-group $RESOURCE_GROUP \
#                 --target-resource-id $JUMPBOX_ID \
#                 --auth-type ssh-key \
#                 --username $JUMPBOX_ADMIN_NAME \
#                 --ssh-key ~/.ssh/id_rsa 
# To get the command, use terraform output:
$(terraform output -raw jumpbox_login_command)
```

At this point, we have logged into our jump box via SSH and can execute commands. You can now connect to the Cosmos DB account terraform created.

Have fun exploring Cosmos!
