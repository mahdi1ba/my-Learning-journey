module "security-group_ssh" {
    source = "terraform-aws-modules/security-group/aws/modules/ssh"
    version = "3.16.0"
    #insert the 2 required variables here
    vpc_id = "vpc-78002E2"
    ingress_cidr_blocks = ["10.10.0.0/16"]
    name ="ssh-access"
}