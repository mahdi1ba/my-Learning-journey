provider "aws" {
    region = "us-west-2"
    access_key = "Akzclkcczmczcz"
    secret_key = "jet7899jlzkcmzcz"
  
}
resource "aws_iam_user" "admin-user" {
    name = "lucy"
    tags = {
        Description = "Technical Team Leader"
    }
}

resource "aws_iam_policy" "adminUser" {
    name = "AdminUsers"
    policy = <<EOF
    {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Effect": "Allow",
                "Action":"*",
                "Resource":"*"
            }
        ]
    }
    EOF
}

resource "aws_iam_user_policy_attachement" "lucy-admin-access" {
    user = aws_iam_user.admin-user.name
    policy_arn = aws_iam_policy.adminUser.arn
}

resource "aws_iam_policy" "adminUser" {
    name = "AdminUsers"
    policy = file("admin-policy.json")
}