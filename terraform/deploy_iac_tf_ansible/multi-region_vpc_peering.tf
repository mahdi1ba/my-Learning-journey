#Initiate Peering connection request from us-east-1

resource "aws_vpc_peering_connection" "useast1-uswest2" {
    provider = aws.region-master
    peer_vpc_id = aws_vpc.vpc_master_oregon.id
    vpc_id = aws_vpc.vpc_master.id
    peer_region = var.region-worker
  
}

#Accept VPC peering request in us-west-2 from us-east-1

resource "aws_vpc_peering_connection_accepter" "accept_peering" {
    provider =  aws.region-worker
    vpc_peering_connection_id = aws_vpc_peering_connection.useast1-uswest2.id
    auto_accept = true
  
}