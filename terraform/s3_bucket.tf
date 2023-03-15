resource "aws_s3_bucket" "finance"{
    bucket = "finance-23333"
    tags = {
      Description = "Finance and payroll"
    }
}

resource "aws_s3_bucket_object" "finance-2022" {
    content = "/root/finance/finance-2020.doc"
    key = "finance-2020.doc"
    bucket = aws_s3_bucket.finance.id #(if the bucket is already created and has a name A then use bucket= "name A")
  
}
data "aws_s3_bucket_policy" "finance-policy" {
    bucket = aws_s3_bucket.finance.id
    policy = <<EOF
    {
        "version": "2012-10-17"
        "statement" : [
            {
                "Action": "*",
                "Effect": "Allow",
                "resource": "arn:aws:s3:::
                "principal":{
                    "aws": [
                        "${data.aws}#group that you want to attach the policy
                    ]
                }
            }
        ]


    }



    EOF
  
}

resource "aws_s3_bucket_object" "upload" {
    bucket = "pixar-studios-2020"
    key    = "woody.jpg"
    source = "/root/woody.jpg"
}