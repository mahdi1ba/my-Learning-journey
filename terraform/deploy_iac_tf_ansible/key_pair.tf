#create key-pair for logging into EC2 in us-east-1
resource "aws_key_pair" "master-key" {
    provider = aws.region-master
    key_name = "jenkins"
    public_key = file("~/.ssh/id_rsa.pub")
}

#create key-pair for logging into EC2 in us-west-2
resource "aws_key_pair" "worker-key" {
    provider = aws.region-worker
    key_name = "jenkins"
    public_key = file("~/.ssh/id_rsa.pub")
}
