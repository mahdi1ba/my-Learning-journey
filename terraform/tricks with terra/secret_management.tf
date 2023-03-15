variable "username"{
    description = "the username for the DB user"
    type = string
    sensitive = true
}

variable "password" {
    description = "the password for the DB user"
    type = string
    sensitive = true  
}

# pass varaibles:

resource "aws_db_instance" "wally" {
    engine = "mysql"
    engine_version = "5.6.17"
    instance_class = "db.t2.micro"
    name = "wally"
    username = var.username
    password = var.password
  
}
# $ export TF_VAR_username=<DB_USERNAME>
# $ export TF_VAR_password=<DB_PASSWORD>

#techinque 2:
# create db-creds.ym and encrypt it using kms
# aws kms encrypt .........
data "aws_kms_secrets" "creds" {
    secret {
      name = "db"
      payload = file("${path.module}/db-creds.yml.encrypted")
    }
}

#parase the YAML file:

locals {
    db_creds = yamldecode(data.aws_kms_secrets.creds.plaintext["db"])
}

resource "aws_db_instance" "dailyplanet" {
    engine = "mysql"
    engine_version = "5.6.17"
    instance_class = "db.t2.micro"
    name = "wally"
    username = local.db_creds.username
    password = local.db_creds.password
}

#third 3 technique
#enter your credentials in aws secret manger
data "aws_secretsmanger_secret_version" "creds"{
    secret_id = "db-creds"
}

locals {
  db_creds = jsondecode(
      data.aws_secretsmanger_secret_version.creds.secret_string
  )
}

resource "aws_db_instance" "dailyplanet" {
    engine = "mysql"
    engine_version = "5.6.17"
    instance_class = "db.t2.micro"
    name = "wally"
    username = local.db_creds.username
    password = local.db_creds.password
}