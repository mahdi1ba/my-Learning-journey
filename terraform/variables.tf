variable "filename" {
    default = "/root/pets.txt"
}
variable "content" {
  default = "we love pets"
}

variable "prefix" {
    default = "Mrs"
}

variable "separator" {
  default = "."
}

variable "length" {
  default = "1"
  type = number
  description = "length of the pet name"
}

variable "prefix" {
    default =  ["Mr", "Mrs", "Sir"]
    type = list
  
}

#not here should be in the main.tf. I will show how to use list type variable

resource "random_pet" "my-pet" {
    prefix = var.prefix[0]
}
####

#list of type
#list of string
variable "prefix" {
    default = ["Mr", "Mrs", "Sir"]
    type = list(string)
}
variable "prefix" {
    default = [1 ,2,3]
    type = list(number)
}

variable "file-content" {
    type = map
    default = {
        "statement1" = "we love pets!"
        "statement2" = "we love animals!"
    }
}
################
resource "local_file" "mypet" {
    filename = "....."
    content = var.file-content["statement2"]
}

###############

variable kitty {
    type = tuple([string, number, bool])
    default = ["cat",1,false]
}

