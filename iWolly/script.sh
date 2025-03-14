#!/bin/bash

# Update and install dependencies
sudo apt-get update -y
sudo apt-get install -y gnupg software-properties-common curl

# Add the HashiCorp GPG key
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -

# Add the HashiCorp Linux repository
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"

# Update to add the repository and install Terraform
sudo apt-get update -y
sudo apt-get install -y terraform
sudo apt-get install -y azure-cli

# Verify the installation
terraform --version

echo "Terraform installation completed successfully!"