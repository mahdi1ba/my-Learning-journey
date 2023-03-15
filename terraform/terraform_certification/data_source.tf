data "aws_key_pair" "cerberus-key" {
    key_name = "alpha"
  
}
resource "aws_instance" "cerberus" {
    ami = var.ami
    instance_type = var.instance_type
    key_name = data.aws_key_pair.cerberus-key.key_name
  
}
#using filter:

data "aws_key_pair" "cerberus-key" {
    filter {
      name = "tag:project"
      values = ["cerberus"]
    }
}