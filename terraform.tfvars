virginia_cidr = "10.10.0.0/16"
#public_subnet = "10.10.1.0/24"
#private_subnet = "10.10.2.0/24"
subnets = ["10.10.1.0/24", "10.10.2.0/24"]

tags = {
    "name" = "prueba"
    "env" = "Dev"
    "owner" = "Alex"
    "IAC" = "Terraform"
    "IAC_Version" = "1.15.2"
    "project" = "cerberus"
    "region" = "virginia"
}

monitoring = true

sg_ingress_cidr = "0.0.0.0/0"

ec2_specs = {
    instance_type = "t3.micro"
    ami_id = "ami-0cca150d127c2216f" # Amazon Linux 2 AMI (HVM), SSD Volume Type
}


ingress_ports_list = [22, 80, 443]