resource "aws_instance" "webserver" {
    ami = var.ami
    instance_type = var.instance_type
    tags = {
      Environment = "Development"
    }
}

variable "ami"{
    default = "ami-2478zkzjkfnzj"

}
variable "region" {
    default = "ca-central-1"
  
}
variable "instance_type" {
    type = map
    default = {
      "development" = "t2.micro"
      "production" = "m5.large"
    }
}
# terraform.workspace
#terraform workspace select production