locals{
    make_bucket = "${var.create_bucket == "true" ? True : false }"
}

resource "google_storage_bucket" "twinkiebucket" {
    count = "${local.make_bucket ? 1 : 0}"
    name = "${var.bucket_name}"
    project = "${var.project_name}"
  
}

# terraform plan -var='create_bucket=true'