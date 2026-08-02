#!/bin/bash
sudo apt update -y
sudo apt install nginx -y
sudo systemctl start nginx
sudo systemctl enable nginx

echo " <h1> Nginx installation and setup completed </h1>" | sudo tee /var/www/html/index.html