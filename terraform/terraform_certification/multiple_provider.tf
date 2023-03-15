resource "random_string" "server-suffix" {
    length = 6
    upper  = false
    special = false
}

resource "aws_instance" "web" {
    ami = "ami-06668929chdzjd"
    instance_type = "m5.large"
    tags = {
      Name = "web-${random_string.server-suffix.id}"
    }
}
