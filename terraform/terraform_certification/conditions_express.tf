resource "random_password" "password-generator" {
    length = var.length < 8 ? 8 : var.length
}

output password {
    value = random_password.password-generator.result
}

variable length {
    type = number
    description = "the length of the password" 
}
