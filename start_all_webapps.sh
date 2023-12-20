#!/bin/bash
# Run this script to start all web apps within a subscription

# No subscription is explicitly set or specified so this will run against the default subscription associated with your account on Azure CLI
# To find out what the default subscription set in your Azure CLI run command below:
# az account show --output json

# To target a specific subscription run:
# az account set --subscription "target_subscription"

# Command to list web apps with required fields in tab-separated format
web_apps_info=$(az webapp list --query "[].{Name:name, ResourceGroup:resourceGroup}" --output tsv)

# Extract web app names and resource groups from tsv output
while IFS=$'\t' read -r name resource_group; do
    # Remove trailing carriage return character from resource_group variable
    resource_group=$(echo "$resource_group" | tr -d '\r')

    echo "Starting Web App: $name in Resource Group: $resource_group"
    az webapp start --name "$name" --resource-group "$resource_group"
done <<< "$web_apps_info"