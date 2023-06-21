#!/bin/bash

# Step 1: Select the GPIO pin for the push button
echo "Select the GPIO pin for the push button (default: 3):"
read -p "> " gpio_pin

# Use GPIO 3 as the default if no input is provided
gpio_pin=${gpio_pin:-3}

# Step 2: Save the shutdown script in a specific location
sudo cp shutdown_button.py /usr/local/bin/shutdown_button.py

# Step 3: Create a systemd service unit
sudo tee /etc/systemd/system/shutdown_button.service > /dev/null <<EOT
[Unit]
Description=Shutdown Button Service
After=multi-user.target

[Service]
Type=idle
ExecStart=/usr/bin/python3 /usr/local/bin/shutdown_button.py
WorkingDirectory=/usr/local/bin
StandardOutput=null

[Install]
WantedBy=multi-user.target
EOT

# Step 4: Enable and start the service
sudo systemctl enable shutdown_button.service
sudo systemctl start shutdown_button.service

# Step 5: Provide option to delete the folder
echo "Do you want to delete this folder? [y/N]"
read answer

if [ "$answer" == "y" ] || [ "$answer" == "Y" ]; then
    cd ..
    sudo rm -rf "$(pwd)"
fi