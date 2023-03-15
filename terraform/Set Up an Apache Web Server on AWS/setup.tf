provider "aws" {
    region = "us-east-1"
}

#create key-pair for logging into EC2 in us-east-1
# a key pair is a combination of a public key that is used to encrypt data and a private key that is used to decrypt data.
# is a set of security credientials that you use to prove your identity when connecting to an amazon EC2 instance.
# amazon EC2 stores the public key on your instance , and you store the private key. for linux instances, the private key allows you to securely ssh into your instance .

resource "aws_key_pair" "webserver-key" {
    key_name = "webserver-key"
    public_key = file("~/.ssh/id_rsa.pub")
}

#Get linux AMI ID using SSM Parameter endpoint in us-east-1
#the amazon linux ami is a supported and maintained linux image provided by amazon web services for use on amazon elastic compute cloud (amazon ec2)
#the machine images are like templates that are configured with an operating system and other software that determine the user's operating environment
# parameter store, a capability of aws systems manager, provides secure hierarchical storage for configuration data management and secrets management.you can 
#store data such as passwords, database strings, amazon machine Image(ami)ids.
data "aws_ssm_parameter" "webserver-ami"{
    name = "/aws/service/ami-amzon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

#create vpc in us-east-1
#amazon vpc enables you to build a virtual network in the aws cloud. -no VPNs,hardware, or physical datacenters required. you can
# define your own network space, and control how your network and the amazon ec2 resources inside your network are exposed to the internet.
resource "aws_vpc" "vpc" {
    cidr_block = "10.0.0.0/16"
    enable_dns_support = true
    enable_dns_hostnames = true
    tags = {
        Name = "terraform-vpc"
    }  
}

#Create IGW in us-east-1
# an internet gateway is a horizontally scaled,redundant, and highly available vpc component that allows communication between your vpc and the internet
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.vpc.id
}

#get main route table to modify 
data "aws_route_table" "main_route_table" {
  filter {
    name   = "association.main"
    values = ["true"]
  }
  filter {
    name   = "vpc-id"
    values = [aws_vpc.vpc.id]
  }
}

#Create route table in us-east-1
# a route table contains a set of rules, called routes, that are used to determine where network traffic from your subnet or gateway is directed.
#to put it simply , a route table tells network packets which way they need to go to get to their destination.

resource "aws_default_route_table" "internet_route" {
  default_route_table_id = data.aws_route_table.main_route_table.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "Terraform-RouteTable"
  }
}

#Get all available AZ's in VPC for master region
data "aws_availability_zones" "azs" {
  state = "available"
}

#Create subnet # 1 in us-east-1
resource "aws_subnet" "subnet" {
  availability_zone = element(data.aws_availability_zones.azs.names, 0)
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.1.0/24"
}

#Create SG for allowing TCP/80 & TCP/22
resource "aws_security_group" "sg" {
  name        = "sg"
  description = "Allow TCP/80 & TCP/22"
  vpc_id      = aws_vpc.vpc.id
  ingress {
    description = "Allow SSH traffic"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "allow traffic from TCP/80"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "Webserver-Public-IP" {
  value = aws_instance.webserver.public_ip
}