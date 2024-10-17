#!/bin/bash
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

sudo mkdir /home/ubuntu/helloworld
cd /home/ubuntu/helloworld || exit
cat > helloworld.html << EOF
<!DOCTYPE html>
<html>
<head>
	<title>Training Docker task 2.1</title>
</head>
<body>
<p>Natallia Seviaryn 2024</p>
</body>
</html>
EOF

cat > Dockerfile << EOF
FROM nginx:latest
COPY helloworld.html /usr/share/nginx/html/index.html
EOF

sudo docker build -t helloworld .
sudo docker run -d -p 80:80 helloworld