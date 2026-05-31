variable "instancias"{
  description = "Número de instancias a crear"
  type = set(string)
  default = ["apache"]
}

resource "aws_instance" "public_instance" {
  for_each = var.instancias
  ami = var.ec2_specs.ami_id
  availability_zone = var.availability_zones[0]
  instance_type = var.ec2_specs.instance_type
  subnet_id = aws_subnet.public_subnet.id
  key_name = data.aws_key_pair.key_pair.key_name
  vpc_security_group_ids = [aws_default_security_group.sg_public_instance.id]
  user_data = file("userdata.sh")
  tags = {
    "Name" = "${each.value}-${local.sufix}"
  }
}

resource "aws_instance" "monitoreo" {
  count = var.monitoring == 1 ? 1:0
  ami = var.ec2_specs.ami_id
  instance_type = var.ec2_specs.instance_type
  subnet_id = aws_subnet.public_subnet.id
  tags = {
    "Name" = "Monitoreo-${local.sufix}"
  }
}