resource "aws_instance" "jenkins-worker-oregon" {
    #...
    provisioner "remote-exec" {
        when  = destroy
        inline = ["echo 'Executing on the remote, provisioned instance ' "]

        connection {
            type = "ssh"
            user = "ec2-user"
            private_key = file("~/.ssh/id_rsa")
            host = self.public_ip
        }
    
    }
    provisioner "local-exec" {
        command = "echo 'Executing on the local instance from which Terraform apply was run '"
    }
}