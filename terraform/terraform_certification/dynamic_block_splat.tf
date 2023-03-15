resource "aws_vpc" "backend-vpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name = "backend-vpc"
    }
}

resource "aws_subnet" "private-subnet" {
    vpc_id = aws_vpc.backend-vpc.id
    cidr_block = "10.0.2.0/24"
    tags = {
      Name = "private-subnet"
    }
  
}

resource "aws_security_group" "backend-sg" {
    name = "backend-sg"
    vpc_id = aws_vpc.backend-vpc.id

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

### dynamic method:

resource "aws_security_group" "backend-sg" {
    name = "backend-sg"
    vpc_id = aws_vpc.backend-vpc.id
    dynamic "ingress" {
        for_each = var.ingress_ports
        content{
            from_port = ingress.value
            to_port  = ingress.value
            protocol = "tcp"
            cidr_block = ["0.0.0.0/0"]
        }
    }
  
}

variable "ingress_ports" {
    type =  list
    default = [22,8080]
}

#terraform apply auto-approve
#slat expression using iterator:

resource "aws_security_group" "backend-sg" {
    name = "backend-sg"
    vpc_id = aws_vpc.backend-vpc.id
    dynamic "ingress" {
        iterator = port
        for_each = var.ingress_ports
        content{
            from_port = ingress.value
            to_port  = ingress.value
            protocol = "tcp"
            cidr_block = ["0.0.0.0/0"]
        }
    }
}

output "to_ports" {
    value = aws_security_group.backend-sg.ingress[*].to_port
  
}