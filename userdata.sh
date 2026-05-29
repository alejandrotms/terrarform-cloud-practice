#!/bin/bash
echo "Hello, World!" > ~/hello.txt
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd