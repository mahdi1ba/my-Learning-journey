resource "aws_instance" "webserver" {
    ami = "ami-0er3zdfkf"
    instance_type = "t2.micro"
    tags = {
      "Name" = "webserver"
      Description = "An nginx webserver on ubuntu"
    }
    user_data = <<-EOF
                #!/bin/bash
                sudo apt update
                sudo apt install nginx -y 
                systemctl enable nginx
                systemctl start nginx
                EOF
    key_name = aws_key_pair.web.id
    vpc_security_group_ids = [ aws_security_group.ssh-access.id ]
}

provider "aws" {
  region = "us-west-1"
}

resource "aws_key_pair" "web" {
  public_key = file("/root/.ssh/web.pub")
}

resource "aws_security_group" "ssh-access" {
    name = "ssh-access"
    description = "Allow SSH access from the Internet"
    ingress ={
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

output publicip {
  value = aws_instance.webserver.public_ip
}