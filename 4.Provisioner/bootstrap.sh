#!/bin/sh
sudo yum install -y httpd
sudo service httpd start
sudo groupadd www
sudo usermod -a -G www ec2-user
sudo usermod -a -G www apache
sudo chown -R apache:www /var/www
sudo chmod 770 -R /var/www