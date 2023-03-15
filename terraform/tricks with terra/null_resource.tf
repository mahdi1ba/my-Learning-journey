resource "aws_instance" "prod_custer" {
    count = 4
    #...
}
resource "null_resource" "prod_cluster" {
    triggers = {
      cluster_instance_ids = join(",",aws_instance.prod_cluster.*.id)
    }

    connection {
        host  = element(aws_instance.prod_cluster.*.public_ip, 0)
    }
    provisioner "remote-exec" {
        inline = [
            "prod_cluster.sh ${join(" ",aws_instance.prod_cluster.*.private_ip)}",
        ]
    }
  
}