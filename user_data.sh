#!/bin/bash

dnf update -y
dnf install nginx -y

systemctl enable nginx
systemctl start nginx

TOKEN=$(curl -X PUT "http://169.254.169.254/latest/api/token" \
-H "X-aws-ec2-metadata-token-ttl-seconds: 21600")

HOSTNAME=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" \
-s http://169.254.169.254/latest/meta-data/hostname)

COLOR=$(shuf -n 1 -e red blue green yellow purple orange cyan)

cat > /usr/share/nginx/html/index.html <<EOF
<html>
<body style="background-color:$COLOR;">
<h1 style="color:white;text-align:center;margin-top:20%;">
CI/CD PIPELINE SUCCESS
<br>
Hostname: $HOSTNAME
</h1>
</body>
</html>
EOF

systemctl restart nginx