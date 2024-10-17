#!/bin/bash
echo "Installation of nginx"

echo "${ssh_private_key}" > /home/ubuntu/.ssh/id_rsa
echo "${ssh_public_key}" > /home/ubuntu/.ssh/id_rsa.pub
chmod 400 /home/ubuntu/.ssh/id_rsa

echo "${ssh_public_key}" >> /home/ec2-user/.ssh/authorized_keys
chmod 600 /home/ubuntu/.ssh/authorized_keys

sudo apt-get update
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

echo "Installation of docker from https://docs.docker.com/engine/install/ubuntu/"
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin