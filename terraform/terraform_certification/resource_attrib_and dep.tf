#implicit dep
resource "aws_key_pair" "alpha"{
    key_name = "alpha"
    public_key = "ssh-rsa..."
}

resource "aws_instance" "cerberus" {
    ami = var.ami
    instance_type = var.instance_type
    key_name = aws_key_pair.alpha.key_name
}

#explicit dep
# for the creation db : first and then web second
resource "aws_instance" "db" {
    ami = var.db_ami
    instance_type = var.web_instance_type
  
}
resource "aws_instance" "db" {
    ami = var.db_ami
    instance_type = var.web_instance_type
    depends_on = [
        aws_instance.db
    ] 
}
# resource targeting:
#an interpolation sequence wrapping

resource "random_string" "server-suffix" {
    length = 6
    upper = false
    special = false
}

resource "aws_instance" "web" {
    ami = "ami-770Gjhsdkjck"
    instance_type = "m5.large"
    tags= {
        Name = "web-${random_string.server-suffix.id}"
    }
}
# when you want to make a change only for the random_string resource and thsi change does not apply the other resource
#$ terraform apply -target random_string.server-sffix
#this is done to make sure that the changes are only applied on the random string resource called server suffix.
#when we do this in the execution plan , terraform will warn us that the resource targeting is in effect during this apply only random resource will applied
#the aws resource is untouched
