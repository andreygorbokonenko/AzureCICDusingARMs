#Azure ARM Template CI/CD Pipeline
Project Overview

This project implements a Continuous Integration and Continuous Deployment (CI/CD) pipeline for exporting and deploying Azure Resource Manager (ARM) templates. The pipeline is designed to automate the process of exporting ARM templates for a resource group, publishing them as build artifacts, and then deploying them to an Azure environment.

The pipeline consists of two main stages:

    Build Stage: Export the ARM template for a resource group and publish it as a build artifact.
    Deploy Stage: Download the exported ARM template and deploy it to a different Azure resource group using the Azure CLI.

The pipeline is built using Azure DevOps YAML syntax and is triggered manually (no automatic triggers for build or pull requests).
Features

    Export ARM Template: The Build stage exports an ARM template for a resource group using a custom Bash script.
    Publish Artifact: The exported template is published as a build artifact, allowing it to be downloaded and used in the Deploy stage.
    Deploy ARM Template: The Deploy stage downloads the ARM template artifact and deploys it to a new resource group using Azure CLI.

Pipeline Structure
1. Build Stage (Build)

This stage exports the ARM template for the resource group and publishes it as a build artifact. It includes the following steps:

    Checkout the repository: Ensures that the latest version of the repository is checked out before proceeding.
    Export the ARM template: A custom script (export_template.sh) is executed using the Azure CLI to export the ARM template of the specified resource group.
    Publish the ARM template: The exported ARM template (rg_resourcegroup1_template.json) is published as a build artifact to make it available for the deployment stage.
    List the files: Lists the contents of the source directory to verify the files that are being worked on.

2. Deploy Stage (Deploy)

This stage downloads the exported ARM template artifact from the build and deploys it to a new resource group using the Azure CLI. The steps include:

    Download the build artifact: The exported ARM template is downloaded from the build artifacts container.
    List the downloaded files: Lists the contents of the artifact staging directory to verify that the artifact has been downloaded.
    Deploy the ARM template: A custom script (deploy_template.sh) is executed using the Azure CLI to deploy the ARM template to a target resource group. Parameters are passed to the script for customization during deployment.

Prerequisites

Before using this pipeline, ensure the following:

    You have an Azure subscription and have configured the Azure CLI with the required permissions to access and deploy resources.
    The Azure DevOps project is set up, and the pipeline is linked to your repository.
    The custom scripts (export_template.sh and deploy_template.sh) are properly configured to export and deploy your ARM templates.

How It Works

    Export ARM Template: The export_template.sh script interacts with Azure CLI to export an ARM template of a resource group.
    Publish Template: The exported ARM template file is published as an artifact for use in the deployment stage.
    Deploy ARM Template: The deploy_template.sh script uses Azure CLI to deploy the ARM template to a specified resource group, using parameter files for customization.

Files

    azure-pipeline.yml: The main YAML file that defines the build and deploy pipeline.
    scripts/export_template.sh: A Bash script that exports the ARM template for a resource group.
    scripts/deploy_template.sh: A Bash script that deploys the ARM template to a resource group using Azure CLI.
    AzureParameters/parameters.json: A parameters file containing custom configuration values for the deployment.

Getting Started

To get started with this pipeline:

    Fork or Clone the repository.
    Ensure that you have set up your Azure DevOps pipeline to use the azure-pipeline.yml file.
    Modify the Azure subscription name in the YAML file and scripts if necessary.
    Ensure that the necessary parameter files are available (such as parameters.json) in the appropriate directory.
    Trigger the pipeline manually by running the build and deployment stages.

Conclusion

This project automates the process of exporting and deploying Azure ARM templates, simplifying the management and deployment of resources in your Azure environment. By using a CI/CD pipeline, you can ensure that your ARM templates are always up-to-date and deployed in a consistent manner.
