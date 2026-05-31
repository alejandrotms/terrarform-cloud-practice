variable "virginia_cidr" {
    description = "CIDR Virginia"
    type = string
  
}

#variable "public_subnet" {
#    description = "CIDR Public Subnet"
#    type = string
#}

#variable "private_subnet" {
#    description = "CIDR Private Subnet"
#    type = string
#}

variable "subnets" {
    description = "Lista de subnets"
    type = list(string)
}

variable "tags" {
    description = "Tags para los recursos"
    type = map(string)
}

variable "monitoring" {
    description = "Habilitar monitoreo"
    type = bool
}

variable "sg_ingress_cidr" {
    description = "CIDR for ingress traffic"
    type = string
}

variable "ec2_specs" {
    description = "Specifications for EC2 instances"
    type = map(string)
}

variable "ingress_ports_list"{
    description = "Lista de puertos para reglas de seguridad"
    type = list(number)
}

variable "access_key" {
    description = "AWS Access key"
}

variable "secret_key"{
    
}