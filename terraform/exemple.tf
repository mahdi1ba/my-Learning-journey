resource "local_file" "state"{
    filename = "/root/${var.local-state}"
    content = "This configuration uses ${var.local-state} state"
}

resource "local_file" "state"{
    filename = "/root/${var.remote-state}"
    content = "This configuration uses ${var.remote-state} state"
}
terraform {
  backend "s3" {
    key = "terraform.tfstate"
    region = "us-east-1"
    bucket = "remote-state"
  }
}
