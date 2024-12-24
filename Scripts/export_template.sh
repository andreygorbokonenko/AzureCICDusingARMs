#!/bin/bash

# Set the required variables
resourceGroupName="rg_resourcegroup1"  # Name of the Azure resource group to export the template from
outputFile="rg_resourcegroup1_template.json"  # File name where the exported template will be saved

# Log in to Azure (we expect the Azure CLI task has already logged in with service principal)
# This comment assumes that the Azure CLI has already been authenticated using a service principal.
# If this is not the case, you may need to run `az login` first in the script or ensure it has been handled previously.

echo "Exporting Resource Group Template for Resource Group: $resourceGroupName"

# Export the resource group template using Azure CLI
# The command `az group export` is used to export the resource group template (in ARM template format) for the specified resource group.
# --name $resourceGroupName specifies the resource group to export the template from.
# --output json ensures that the output is in JSON format.
# The result is saved to a file specified by $outputFile (in this case, "rg_resourcegroup1_template.json").
az group export --name $resourceGroupName --output json > $outputFile

# Check if the export was successful
# $? is a special variable that stores the exit status of the last executed command.
# If the export command is successful, the exit status will be 0. If there was an error, it will be a non-zero value.
if [ $? -eq 0 ]; then
  # If the exit status is 0 (success), print a success message
  echo "Resource group template exported successfully to $outputFile"
else
  # If the exit status is not 0 (failure), print an error message and exit the script with a non-zero status
  echo "Failed to export resource group template"
  exit 1  # This will terminate the script with an error status code (1)
fi

# End of the script