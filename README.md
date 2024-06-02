# Azure Infrastructure Deployment with Terraform

This README file provides an overview of the Terraform configuration for deploying resources in Azure, including virtual networks, subnets, public IPs, security groups, network interfaces, and virtual machines. This configuration assumes you have basic knowledge of Terraform and have set up your Azure provider.

## Configuration Overview

The Terraform configuration consists of the following main resources:

1. **Resource Group**: Defines the Azure resource group to contain all resources.
2. **Virtual Network**: Creates a virtual network for the infrastructure.
3. **Subnet**: Creates a subnet within the virtual network.
4. **Public IP**: Allocates a public IP address.
5. **Network Security Group (NSG)**: Defines security rules for inbound traffic.
6. **Network Interface**: Creates a network interface and associates it with the NSG.
7. **Virtual Machine (VM)**: Deploys a Linux virtual machine.
8. **Null Resource**: Executes remote commands on the VM to set up OpenVPN.

## Terraform Resources

### Azure Resource Group

Creates an Azure resource group with the specified name and location.

### Virtual Network

Creates a virtual network with the specified address space.

### Subnet

Defines a subnet within the virtual network.

### Public IP

Allocates a dynamic public IP address.

### Network Security Group

Configures inbound security rules for the NSG.

### Network Interface

Creates a network interface with a dynamic private IP address and associates it with the NSG.

### VM Configuration

Deploys a Linux VM with the specified configuration, including admin credentials, size, OS disk, and image reference.

### Null Resource (Script Execution)

Executes remote commands on the VM to set up OpenVPN using a random password generated during deployment.

## Usage

1. Ensure you have Terraform installed locally.
2. Update the variables in the `variables.tf` file as per your requirements.
3. Initialize Terraform with `terraform init`.
4. Review the execution plan with `terraform plan`.
5. Apply the configuration with `terraform apply`.

## Variables

You can customize the deployment by modifying the variables in the `variables.tf` file.

- `prefix`: Prefix to be used for naming resources.

## Note
- Ensure you have Azure Powershell module or Azure CLI installed to be able to login to you azure account and connect to your subscription
- This configuration assumes you have appropriate permissions to deploy resources in Azure.
- Ensure proper handling of sensitive information like passwords and SSH keys.
- Review and customize security configurations as per your organization's requirements.

For more details on Terraform and Azure, refer to the official documentation:

- [Terraform Documentation](https://www.terraform.io/docs/index.html)
- [Azure Provider Documentation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
