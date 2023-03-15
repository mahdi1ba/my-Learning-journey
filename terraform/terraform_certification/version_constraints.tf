terraform {
    required_providers {
        local = {
            source = "hashicorp/local"
            version = "1.4.0"
        }
    }
}

resource "local_file" "pet"{
    filename = "/root/pet.txt"
    content = "we love pets!"
}

#another exemple .. look at the operators behind version

terraform {
    required_providers {
        local = {
            source = "hashicorp/local"
            version = "> 1.2.0, < 2.0.0, != 1.4.0"
        }
    }
}
# terraform can download 1.2 or any incremental version such as 1.3,1.4,1.5,1.6
terraform {
    required_providers {
        local = {
            source = "hashicorp/local"
            version = "~> 1.2"
        }
    }
}

