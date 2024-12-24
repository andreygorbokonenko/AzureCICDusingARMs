#!/bin/bash

# Arguments passed to the script
# $1, $2, $3 represent the command-line arguments provided when executing the script.
# These values are assigned to the respective variables:

templateFile=$1  # Path to the ARM template file (JSON or Bicep)
resourceGroupName=$2  # Name of the resource group where the template will be deployed
parametersFile=$3  # Path to the parameters file for the ARM template deployment

location="westus"  # Location where the resource group will be created if it doesn't exist (can be changed as needed)

# Log the arguments for informational purposes
echo "Using template: $templateFile"  # Log the template file being used
echo "Deploying to Resource Group: $resourceGroupName"  # Log the resource group being targeted for the deployment

# Check if the template file exists
# This verifies that the file path passed as the template file exists before proceeding.
if [ ! -f "$templateFile" ]; then
  echo "Template file not found: $templateFile"  # Error message if the file doesn't exist
  exit 1  # Exit with a non-zero status to indicate failure
fi

# Check if the parameters file exists
# This checks if the parameters file exists before proceeding with the deployment.
if [ ! -f "$parametersFile" ]; then
  echo "Parameters file not found: $parametersFile"  # Error message if the parameters file doesn't exist
  exit 1  # Exit with a non-zero status to indicate failure
fi

# Check if the resource group exists using the Azure CLI command `az group exists`
# This command returns "true" if the resource group exists, otherwise it returns "false".
rgExists=$(az group exists --name $resourceGroupName)

# If the resource group doesn't exist, create it
if [ "$rgExists" = "false" ]; then
  echo "Resource group $resourceGroupName does not exist. Creating it..."  # Inform the user that the group doesn't exist and creation will start
  # The command `az group create` is used to create the resource group in the specified location.
  az group create --name $resourceGroupName --location $location
  if [ $? -ne 0 ]; then
    # If the group creation fails (non-zero exit status), show an error message
    echo "Failed to create resource group $resourceGroupName"
    exit 1  # Exit with a non-zero status to indicate failure
  fi
else
  # If the resource group already exists, notify the user
  echo "Resource group $resourceGroupName already exists."
fi

# Deploy the ARM template using Azure CLI `az deployment group create`
echo "Deploying the template to the resource group..."  # Inform the user that the deployment is starting

# `az deployment group create` is the Azure CLI command used to deploy an ARM template to a resource group.
# --resource-group specifies the target resource group.
# --template-file specifies the path to the ARM template file.
# --parameters specifies the parameters file (using @ to read the file content).
az deployment group create \
  --resource-group $resourceGroupName \
  --template-file $templateFile \
  --parameters @$parametersFile

# Check if the deployment was successful
# $? holds the exit status of the last executed command. A value of 0 means success, any non-zero value indicates failure.
if [ $? -eq 0 ]; then
  echo "Deployment completed successfully."  # Inform the user that the deployment was successful
else
  echo "Deployment failed."  # Error message if deployment failed
  exit 1  # Exit with a non-zero status to indicate failure
fi

# End of the script
