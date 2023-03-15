resource "aws_instance" "webserver"{
    ami = var.ami
    instance_type = var.instance_type
}

variable "ami" {
    default = "ami-kcslcknlfef00986b"
    description = "Type of AMI to use"
    type = string
}

variable "instance_type" {
    default = "t2.micro"
    description = "Type of AMI to use"
    type = string
    sensitive = true 
}
# sensitive variable will be suppressed when running operations such as terraform plan or apply Now the values, howerver will be recorded in the terraform state ,respective this variable is set to true or false 
####2### other method we can set the value of the variables when running terraform apply
# don't set defult value to the variable like this :

variable "ami" {  
}
variable "instance_type" { 
}
# when running apply command it will request you to enter value 

####3### another way for passing variables

# in the command itself:

# $ terraform apply -var "ami=ami-0IIHBHH7665teyun" -var "instance_type=t2.micro"

####4#### another method is by using env variable

# $ export TF_VAR_instance_type="t2.micro"
# $ terraform apply

####5#### by using variable.tfvars

ami="ami-0666yhskck"
instance_type="t2.micro"

# terraform.tfvars | terraform.tfvars.json | *.auto.tfvars | *.auto.tfvars.json 
# automatically loaded

#otherwise when passing apply command add this options : -var-file 
# $ terraform apply -var-file variable.tfvars

# prio for terraform:
#1) -var or -var-file (command-line flags)
#2)*.auto.tfvars(alphabetical order)
#3)terraform.tfvars
#4)Environment variables

# terraform load (begin 4 ===> 1)

###########################################################################
#validation of variable 
variable "ami" {
    type = string
    description = "the id of the machine image (AMI) to use for the server"
        validation {
            condition = substr(var.ami,0,4) == "ami-"
            error_message = "The AMI should start with \"ami-\"."
        }
}

variable "count" {
    default = 2
    type = number
    description = "Count of VM's"
}

variable "monitoring" {
    default = true
    type = bool
    description = "enbaled detailed monitoring"
}

######## varaible list:

variable "servers"{
    default = ["web1","web2","web3"]
    type = list
}
# how we can use it :
resource "aws_instance" "web" {
    ami = var.ami
    instance_type = var.instance_type
    tags = {
      name = var.servers[0]
    }
}

######## varaible map :
# a map is data represented in the format of key-value pairs 

variable instance_type {
    type = map
    default = {
        "production" = "m5.large"
        "development"= "t2.micro"
    }
  
}

# to use map in resource block

resource "aws_instance" "production" {
    ami = var.ami
    instance_type = var.instance_type["development"]
}

#variable can be :
#type = list(string)
#type = list(number)

#map of number

variable "instance_type" {
    default = {
        "production" = "m5.large"
        "develompent" = "t2.micro"
    }
    type = map(string)
  
}

variable "server_count" {
    default = {
        "web" = 3
        "db" = 1
        "agent" = 2
    }
    type = map(number)
}
#set

variable "servers"{
    default = ["web1","web2","web3"]
    type = set(string)
}

variable "count" {
    default = [10,12,15]
    type = set(number)
}

#object:

variable "bella" {
    type = object({
        name = string
        color  = string
        age = number
        food = list(string)
        favorite_pet = bool

    })
  
}

# Tuples:

variable web {
    type = tuple([string, number, bool])
    default = ["web1",3,true]
}

# output variables

# these variables can be used to store the value of an expression in terraform
#for exemple to store the public IP address an ec2 instance created by the resource block called web we can make use of an output varaiable

resource "aws_instance" "cerberus" {
    ami = var.ami
    instance_type = var.instance_type

}

output "pub_ip" {
    value = aws_instance.cerberus.public_ip
    description = "print the public IPv4 address"
}

# $ terraform output
# $ terraform output pub_ip