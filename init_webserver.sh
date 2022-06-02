#!/bin/bash
sudo su
sudo apt update -y
sudo apt install apache2 -y
sudo cp /home/ubuntu/html/* /var/www/html/
sudo systemctl enable apache2.service
sudo systemctl start apache2.service