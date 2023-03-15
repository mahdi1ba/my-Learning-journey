resource "aws_instance" "web"{
    ami =  "ami-807065564hjsc"
    instance_type = "t2.medium"
    tags = local.common-tags
}

resource "aws_instance" "db" {
    ami = "ami-97665afsjdks"
    instance_type = "m5.large"
    tags = local.common_tags
}

locals {
    common_tags = {
        Departement = "finance"
        Project = "cerberus"
    }
}
###### another exemple:
resource "aws_s3_bucket" "finance_bucket" {
    acl = "private"
    bucket = local.bucket-prefix
  
}

resource "random_string" "random-suffix" {
    length = 6
    special = false
    upper = false
}

variable "Project" {
    default = "cerberus"
}

locals {
    bucket-prefix = "${var.project}-${random_string.random-suffix.id}-bucket"   
}
