#!/bin/bash
# Run this script to start or stop a specific Azure web app.
# The current state of the web app is checked to figure out which action is needed.
# The URL of web app is given at the end to use as needed.

# To find out your web app's name and resource group, you can try something like the following:
# az webapp list --output table

# Assign the web app name and resource group to the variables below
web_app_name="your_web_app_name"
resource_group="your_web_app_resource_group"

# Fetch the web app details including URL and state
web_app_url=$(az webapp show --name $web_app_name --resource-group $resource_group --query "defaultHostName" --output tsv)
web_app_state=$(az webapp show --name $web_app_name --resource-group $resource_group --query "state" --output tsv)

# Check the current state of the web app. Start or stop it.
if [ "$web_app_state" == "Running" ]; then
    echo "$web_app_name is currently running. Stopping it..."
    az webapp stop --name $web_app_name --resource-group $resource_group
elif [ "$web_app_state" == "Stopped" ]; then
    echo "$web_app_name is currently stopped. Starting it..."
    az webapp start --name $web_app_name --resource-group $resource_group
else
    echo "$web_app_name is in an unknown state: $web_app_state"
fi

# Display the URL to the user (last line).
echo "Web App URL: $web_app_url"