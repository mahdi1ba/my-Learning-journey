resource "aws_instance" "cerberus" {
    ami = "ami-8667909zeef"
    instance_type = "m5.large"
    tags = {
      Name = "Cerberus-webserver"
    }
    lifecycle {
        create_before_destroy = true
    }
  
}
###
resource "aws_instance" "cerberus" {
    ami = "ami-8667909zeef"
    instance_type = "m5.large"
    tags = {
      Name = "Cerberus-webserver"
    }
    lifecycle {
        prevent_destroy = true
    }
  
}

###ignore_changes(tags for this exemple )
resource "aws_instance" "cerberus" {
    ami = "ami-8667909zeef"
    instance_type = "m5.large"
    tags = {
      Name = "Cerberus-webserver"
    }
    lifecycle {
        ignore_changes = [
            tags
        ]
    }
  
}
### ignore changes (all)
resource "aws_instance" "cerberus" {
    ami = "ami-8667909zeef"
    instance_type = "m5.large"
    tags = {
      Name = "Cerberus-webserver"
    }
    lifecycle {
        ignore_changes = all
    }
  
}