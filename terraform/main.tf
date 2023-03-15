resource "aws_instance" "webserver" {
    ami = "ami-1234555555778990"
    instance_type = "t2.micro"
}

resource "aws_s3_bucket" "finance" {
    bucket = "finance-21092020"
    tags = {
      Description = "Finance and Payroll"
    }
  
}

resource "aws_iam_user" "admin-user" {
    name = "lucy"
    tags = {
      Description = "Team Leader"
    }
}

resource "random_pet" "my-pet" {
  prefix = "Mrs"
  separator = "."
  length = "1"
}

resource "random_pet" "my-pet" {
  prefix = var.prefix
  separator = var.separator
  length = var.length
}