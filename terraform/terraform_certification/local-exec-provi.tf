resource "aws_instance" "webserver"{
    ami = "ami-0hkzhs5677"
    instance_type = "t2.micro"
    provisioner "local-exec" {
        command = "echo ${aws_instance.webserver.public_ip} >> /tmp/ips.txt"
    }
    provisioner "local-exec" {
        when = destroy
        command  = "echo Instance ${aws_instance.webserver.public_ip} Destroyed! > /tmp/instance_state.txt"
    }
}
resource "aws_instance" "web" {
  # ...

  provisioner "local-exec" {
    command = "echo The server's IP address is ${self.private_ip}"
  }
}