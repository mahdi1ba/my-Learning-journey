resource "random_password" "password-generator"{
    length = var.length
}

output password {
    value = random_password.password-generator.result
}

variable length {
    type = number
    description = "The lenth of the password"
}

# terraform apply -var=length=5 -auto-approve

# if $length -lt 8
#   then
#        length=8
#        echo $length;
#    else
#        echo $length;
#    fi
# rule : condition ? true_val : false_val  
resource "random_password" "password-generator"{
    length = var.length < 8 ? 8: var.length
}
#explication if length < 8 it will made the length equal to 8 otherwise it will be the value of length itself.
#terraform apply -var=length=5 ==> it will remain the length to 8
#terraform apply -var=length=12 ==> it will remain the length to 12

resource "aws_instance" "mario_servers" {
     ami = var.ami
     instance_type = var.name == "tiny" ? var.small : var.large
     tags = {
          Name = var.name

     }

}

resource "aws_instance" "projectA" {
    ami = "ami-098776YHBNJJkk"
    instance_type = "t2.micro"
    tags = {
      Name = "ProjectA"
    }
  
}
