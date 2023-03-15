terraform {
    backend "s3"{
        bucket = "kodekloud-terraform-state-bucket01"
        key = "finance/terraform.tfstate"
        region = "uss-west-1"
        dynamo_table = "state-locking"
    }
    
}