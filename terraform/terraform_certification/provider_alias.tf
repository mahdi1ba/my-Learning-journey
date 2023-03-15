provider "aws" {
    region = "us-east-1"
}

provider "aws" {
    region = "ca-central-1"
    alias = "central"
}

#in the main.tf when you want to deploy a resource in ca-central-1 you should use alias use syntax [provider = aws.central]

resource "aws_key_pair" "beta" {
    key_name = "beta"
    public_key = "ssh-rsa ABZKECLZFZLSF"
    provider = aws.central
}