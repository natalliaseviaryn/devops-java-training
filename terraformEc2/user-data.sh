#!/bin/bash
echo "Installation of nginx"

sudo apt-get update -y
sudo apt-get install -y nginx
sudo systemctl start nginx
sudo systemctl enable nginx
cd /var/www/html

cat > helloworld.html << EOF
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
html { color-scheme: light dark; }
body { width: 35em; margin: 0 auto;
font-family: Tahoma, Verdana, Arial, sans-serif; }
</style>
</head>
<body>

<h2>Hello world! Generated from user-data</h2>

<p><b>Operating system: </b> Ubuntu</p>
</body>
</html>
EOF
