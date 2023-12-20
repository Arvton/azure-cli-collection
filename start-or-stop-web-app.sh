#!/bin/bash
# Run this script to start or stop a specific Azure web app
# The current state of the web app is checked to figure out which action is needed.
# To find out your web app's name and resource group, you can try something like the following:
# az webapp list --output table

# Assign the web app name and resource group to the variables below
web_app_name="your_web_app_name"
resource_group="your_web_app_resource_group"

# Fetch the web app details including URL and state
web_app_info=$(az webapp show --name $web_app_name --resource-group $resource_group --query "[url,state]" --output tsv)
read -r web_app_url web_app_state <<< "$web_app_info"

# Check the current state of the web app
if [ "$web_app_state" == "Running" ]; then
    echo "Web App is currently running."
elif [ "$web_app_state" == "Stopped" ]; then
    echo "Web App is currently stopped."
else
    echo "Web App is in an unknown state: $web_app_state"
fi

# Display the URL to the user (last line).
echo "Web App URL: $web_app_url"