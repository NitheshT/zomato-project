#!/bin/bash
 
echo "ClientAliveInterval 60" >> /etc/ssh/sshd_config
echo "LANG=en_US.utf-8" >> /etc/environment
echo "LC_ALL=en_US.utf-8" >> /etc/environment
systemctl restart sshd.service
 
yum install httpd php -y
systemctl restart httpd.service php-fpm.service
systemctl enable httpd.service php-fpm.service
 
cat <<EOF > /var/www/html/index.php
<?php
\$output = shell_exec('echo $HOSTNAME');
echo "<h1><center><pre>\$output</pre></center></h1>";
echo "<h1><center>Zomato Production Site</center></h1>"
?>
EOF
