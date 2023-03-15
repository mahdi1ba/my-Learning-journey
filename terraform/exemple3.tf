resource "aws_instance" "webserver" {
    ami = "ami-0ebder4dncslsd"
    instance_type = "t2.micro"
    tags = {
      Name = "webserver"
      Description = "An Nginx Webserver on ubuntu"
    }
    provisioner "remote-exec" {
        inline = ["echo $(hostname -i) >> /tmp/ips.txt"]
    
    }
}

