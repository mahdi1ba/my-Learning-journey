#format.tf

locals {
    hostname = "${format("%d-%s-%s-%s-%04d-%s", var.region, var.env, var.app, var.type, var.cluster_id, var.id)}"
}

#matchkeys.tf

instances = [
    "${matchkeys(
        google_complete_instance.compute_instance.*.self_link,
        google_compute_instance.compute_instance.*.zone,
        data.google_comute_zones.available.names[0])}"
]

#matchkeys(["i-123", "i-abc", "i-def"], ["us-west", "us-east", "us-east"], ["us-east"])
#[
#  "i-abc",
#  "i-def",
#]

#element.tf
list = ["twinkie","snowball","yum"]
# ${element(var.list, 0)} == twinkie
# ${element(var.list, 1)} == snowball
# ${element(var.list, 2)} == yum
# ${element(var.list, 3)} == twinkie 
