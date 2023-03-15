module "security-group" {
    source =  "terraform-aws-module/security-group/aws/modules/ssh"
    version = "3.16.0"
    #insert thee 2 required variables here .
}
# module composition:
module "network" {
  source = "./modules/aws-network"
  ...
}

module "consul_cluster" {
  source = "./modules/aws-consul-cluster"
  ...
}