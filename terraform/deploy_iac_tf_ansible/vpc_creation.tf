#Create VPC in us-east-1
resource "aws_vpc" "vpc_master" {
    provider = aws.region-master
    cidr_block = "10.0.0.0/16"
    enable_dns_support = true
    enable_dns_hostnames = true
    tags = {
        Name = "master-vpc-jenkins"
    }
  
}

#create vpc in us-west-2
resource "aws_vpc" "vpc_master_oregon" {
    provider = aws.region-worker
    cidr_block = "192.168.0.0/16"
    enable_dns_support = true
    enable_dns_hostnames = true
    tags = {
        Name = "worker-vpc-jenkins"
    }
  
}

