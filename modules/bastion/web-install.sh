#!/bin/bash
  yum update -y
  yum install -y httpd.x86_64
  systemctl start httpd.service
  systemctl enable httpd.service
  instanceId=$(curl http://169.254.169.254/latest/meta-data/instance-id)
  instanceAZ=$(curl http://169.254.169.254/latest/meta-data/placement/availability-zone)
  pubHostName=$(curl http://169.254.169.254/latest/meta-data/public-hostname)
  pubIPv4=$(curl http://169.254.169.254/latest/meta-data/public-ipv4)
  privHostName=$(curl http://169.254.169.254/latest/meta-data/local-hostname)
  privIPv4=$(curl http://169.254.169.254/latest/meta-data/local-ipv4)
  
  echo "<font face = "Verdana" size = "5">"                               > /var/www/html/index.html
  echo "<center><h1>Bastion Host Deployed with Terraform</h1></center>"   >> /var/www/html/index.html
  echo "<center> <b>EC2 Instance Metadata</b> </center>"                  >> /var/www/html/index.html
  echo "<center> <b>Instance ID:</b> $instanceId </center>"               >> /var/www/html/index.html
  echo "<center> <b>AWS Availablity Zone:</b> $instanceAZ </center>"      >> /var/www/html/index.html
  echo "<center> <b>Public Hostname:</b> $pubHostName </center>"          >> /var/www/html/index.html
  echo "<center> <b>Public IPv4:</b> $pubIPv4 </center>"                  >> /var/www/html/index.html
  echo "<center> <b>Private Hostname:</b> $privHostName </center>"        >> /var/www/html/index.html
  echo "<center> <b>Private IPv4:</b> $privIPv4 </center>"                >> /var/www/html/index.html
  echo "</font>"                                                          >> /var/www/html/index.html