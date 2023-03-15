# using data source (ssm parameter store) to fetch AMI IDs
#fetch ami_id which we'll using to spin up the systems on which we'll be installing our jenkins applications and running all the bootstarpping and provisioning various software packages on it 
#data source it's only for querying already existing resources 
data "aws_ssm_parameter" "AmazonOfficialAMI"{
    name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"

}

#ssm parameter store - parameters for public AMI IDs
#{
#    "parametres": [
#        {
#        "Name" :"/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
#        "Type": "String"
#        "Value": "ami-0765YGUHJKJLKJ",
#        }
#    ]
#}

#ssm is known as systems manger . the acronym comes from the earlier name of the serice 
#which was simple systems manger 

#fetching value
#data.aws_ssm_parameter.AmazonOfficialAMI.value == ami-08687565GHGHJ

##########
#get linux ami id using ssm parameter endpoint in us-east-1
data "aws_ssm_parameter" "linuxAmi" {
    provider = aws.region-master
    name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

#get linux ami id using ssm parameter endpoint in us-west-2
data "aws_ssm_parameter" "linuxAmiOregon" {
    provider = aws.region-worker
    name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}
