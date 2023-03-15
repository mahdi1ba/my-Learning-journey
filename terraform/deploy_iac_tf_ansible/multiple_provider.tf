provider "aws"{
        profile = var.profile
        region = var.region-master
        alias = "region-master"
}

provider "aws" {
    profile = var.profile
    region = var.region-worker
    alias = "region-worker"
}

variable "profile" {
    type = string
    default = "default"
}

variable "region-master" {
    type = string
    default = "us-east-1"
}

variable "region-worker" {
    type = string
    default = "us-west-2"
}
