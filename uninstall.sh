#!/bin/bash

# Step 1: Stop and disable the service
sudo systemctl stop shutdown_button.service
sudo systemctl disable shutdown_button.service

# Step 2: Remove the service file
sudo rm /etc/systemd/system/shutdown_button.service

# Step 3: Remove the shutdown script
sudo rm /usr/local/bin/shutdown_button.py

echo "Uninstallation completed successfully."