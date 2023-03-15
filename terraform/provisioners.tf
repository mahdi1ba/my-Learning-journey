resource "aws_instance" "webserver" {
    ami = "ami-0lscsnsqdzadl"
    instance_type = "t2.micro"
    provisioner "remote-exec" {
        inline = [
            "sudo apt update",
            "sudo apt install nginx -y",
            "sudo systemctl enable nginx",
            "sudo systemctl start nginx"
        ]
    
    }
    connection {
        type = "ssh"
        host = self.public_ip
        user = "ubuntu"
        private_key = file("/root/.ssh/web")
    }
    key_name = aws_key_pair.web.id
    vpc_security_group_ids = [ aws_security_group.ssh-access.id ]
}

resource "aws_security_group" "ssh-access" {
  
}

# local exec

resource "aws_instance" "webserver" {
    ami = "ami-09987655444"
    instance_type = "t2.micro"

    provisioner "local-exec" {
        on_failure = continue 
        #on_failure = fail(by default)
        command = "echo ${aws_instance.webserver. public_ip} created! >> /tmp/ips.txt"
    
    }
    provisioner "local-exec" {
        when = destroy
        command = "echo Instance ${aws_instance.webserver.public_ip} Destroyed! > /tmp/instance_state.txt"
    
    }
}

