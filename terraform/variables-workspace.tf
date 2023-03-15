variable region {
    default = "ca-central-1"
}

variable instance_type {
    default = "t2.micro"
}

variable ami {
    type = map
    default = {
        "ProjectA" = "ami-0edjdza34567"
        "ProjectB" = "ami-0ljzcle88700"
    }
}

resource "aws_instance" "projectA" {
    ami = lookup(var.ami,terraform.workspace)
    instance_type =  var.instance_type
    tags = {
        Name = terraform.workspace
    }
  
}

# lookup(var.ami, terraform.workspace)
# terraform workspace new ProjectB

# to switch to workspace ProjectA:
# terraform workspace select ProjectA 
# tree terraform.tfstate.d

variable "region" {
    type = map
    default = {
        "us-payroll" = "us-east-1"
        "uk-payroll" = "eu-west-2"
        "india-payroll" = "ap-south-1"
    }

}
variable "ami" {
    type = map
    default = {
        "us-payroll" = "ami-24e140119877avm"
        "uk-payroll" = "ami-35e140119877avm"
        "india-payroll" = "ami-55140119877avm"
    }
}

module "payroll_app" {
  source = "/root/terraform-projects/modules/payroll-app"
  app_region = lookup(var.region, terraform.workspace)
  ami        = lookup(var.ami, terraform.workspace)
}