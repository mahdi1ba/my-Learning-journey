variable "num" {
    type = set(number)
    default = [250,10, 11,5]
    description = "A set of numbers"
}

variable "ami" {
    type = string
    default = "ami-xyz,AMI-ABC,ami-efg"
    description = "A string containing ami ids"
}

# terraform console: split(",","ami-xyz,ami-ABC") ==> output: [ami-xyz,ami-ABC]
#lower(var.ami)
#upper(var.ami)
#title(var.ami): made the first letter in maj
#substr(var.ami,16,7): extract 7 caracter from the 16th caracter
#join
#join(",",["ami-xyz","ami-abc","ami-efg"])
#length(var.ami) length of list 
#index(var.ami,"ami-abc")==> index begins from 0
#element(var.ami,2)==> return the element in list that has index 2
#contains(var.ami,"ami-abc")==> verify that the element is in the list (true, false)

variable "ami" {
    type = map
    default = {
        "us-east-1" = "ami-xyz",
        "ca-central-1" = "ami-efg",
        "ap-south-1" = "ami-ABC"
    }
    description = "a map of ami ID's for specific regions"
}

#keys(var.ami) : return the keys
#values(var.ami): return the values 
#lookup(var.ami,"ca-central-1") ==> return (ami-efg) value
#lookup(map,key)
#lookup(map,key,value)===> will return the value because it will submit it as defualt value for the key.

##Operators & conditional expressions
# +/-/*/
#==/!=
# && , ||
variable special{
    type = bool
    default = true
    description = "Set to true to use special caracters"
}
# ! var.special ==> return False
variable b {
    type = number
    default = 25
}

variable b {
  type = number
  default = 25
}

# var.a > var.b ==> return true
#split("separator",stringvariable)
#exemple : split(":",var.cloud_users)
#length(list)
#length(var.cloudusers)
