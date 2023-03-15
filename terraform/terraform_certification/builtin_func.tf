resource "aws_iam_policy" "adminUser" {
    name = "AdminUsers"
    policy = file("admin-policy.json")
}
resource "local_file" "pet" {
    filename = var.filename
    for_each = length(var.filename)
}

resource "local_file" "pet" {
    filename = var.filename
    for_each = toset(var.filename)
}

variable region {
    type = list
    default = ["us-east-1",
                "us-east-1",
                "ca-central-1"]
    desdescription = "a list of aws Regions"   
  
}