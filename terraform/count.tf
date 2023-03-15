resource "local_file" "pet" {
    filename = var.filename[count.index]
    count = length(var.filename)
}

variable "filename" {
    default = [
        "/root/pets.txt",
        "/root/dogs.txt",
        "/root/cats.txt",
        "/root/cows.txt",
        "/root/ducks.txt"
    ]
}

resource "local_file" "name" {
    filename = each.value
    for_each = toset(var.users)
    sensitive_content = var.content
}

variable "users" {
  type = list(string)
  default = [ "/root/user10","/root/user11","/root/user12" ]
}

