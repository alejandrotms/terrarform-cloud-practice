resource "aws_vpc" "vpc_virginina" {
  cidr_block = var.virginia_cidr
  tags = {
    Name = "VPC_VIRGINIA-${local.sufix}"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id = aws_vpc.vpc_virginina.id
  cidr_block = var.subnets[0]
  map_public_ip_on_launch = true
  tags = {
    Name = "Public_Subnet-${local.sufix}"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id = aws_vpc.vpc_virginina.id
  cidr_block = var.subnets[1]
  tags = {
    Name = "Private_Subnet-${local.sufix}"
  }
  depends_on = [aws_subnet.public_subnet]
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc_virginina.id

  tags = {
    Name = "IGW VIRGINIA-${local.sufix}"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc_virginina.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = {
    Name = "public crt-${local.sufix}"
  }
}

resource "aws_route_table_association" "crta_public_subnet" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_default_security_group" "sg_public_instance" {
  vpc_id = aws_vpc.vpc_virginina.id

  dynamic "ingress" {
    for_each = var.ingress_ports_list
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = [var.sg_ingress_cidr]
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "Public Instance SG-${local.sufix}"
    description = "Allow SSH inbound and all outbound traffic"
  }
}

module "my_s3_bucket" {
  source = "./modulos/s3"
  bucket_name = "nombreunico-1231535"
}

output "s3_bucket_arn" {
  value = module.my_s3_bucket.s3_bucket_arn
}

#module "terraform_state_backend" {
#  source = "cloudposse/tfstate-backend/aws"
# Cloud Posse recommends pinning every module to a specific version
#  version     = "1.9.0"
#  namespace  = "pruebas-terraform"
#  stage      = "prod"
#  name       = "terraform"
#  attributes = ["state"]
#  environment  = "us-east-1"
#  terraform_backend_config_file_path = "."
#  terraform_backend_config_file_name = "backend.tf"
#  force_destroy                      = false
#}
