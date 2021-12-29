#!/bin/bash

sudo apt-get update && sudo apt upgrade -y
sudo apt-get install apache2 -y
sudo chgrp -R ubuntu  /var/www
sudo chmod -R g+rw   /var/www
myip=`curl http://169.254.169.254/latest/meta-data/local-ipv4`
echo "<h2>WebServer with IP: $myip</h2><br>I feel the Power! The Power of Terraform !!! :-)"  >  /var/www/html/index.html