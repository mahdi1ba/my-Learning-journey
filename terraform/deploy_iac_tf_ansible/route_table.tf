#Create route table in us-east-1

resource "aws_route_table" "internet_route" {
    provider = aws.region-master
    vpc_id = aws_vpc.vpc_master.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
    route {
        cidr_block =  "192.168.1.0/24"
        vpc_peering_connection_id = aws_vpc_peering_connection.useast1-uswest2.id
    }
    lifecycle {
        ignore_changes = all
    }
    tags = {
      Name = "Master-Region-RT"
    }
}

#Overwrite defualt route table of VPC(master) with our route table entries

resource "aws_main_route_table_association" "set-master-default-rt-assoc" {
    provider = aws.region-master
    vpc_id = aws_vpc.vpc_master.id
    route_table_id = aws_route_table.internet_route.id 
}

#Create route table in us-west-2

resource "aws_route_table" "internet_route_oregon" {
    provider = aws.region-master
    vpc_id = aws_vpc.vpc_master_oregon.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
    route {
        cidr_block =  "10.0.1.0/24"
        vpc_peering_connection_id = aws_vpc_peering_connection.useast1-uswest2.id
    }
    lifecycle {
        ignore_changes = all
    }
    tags = {
      Name = "Worker-Region-RT"
    }
}

#Overwrite defualt route table of VPC(worker) with our route table entries

resource "aws_main_route_table_association" "set-worker-default-rt-assoc" {
    provider = aws.region-worker
    vpc_id = aws_vpc.vpc_master_oregon.id
    route_table_id = aws_route_table.internet_route_oregon.id 
}
