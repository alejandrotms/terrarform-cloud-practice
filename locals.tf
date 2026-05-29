locals {
  sufix = "${var.tags.project}-${var.tags.env}-${var.tags.region}"
}

resource "random_string" "bucket_suffix" {
  length  = 8
  upper   = false
  special = false
}

locals {
  s3-sufix = "${var.tags.project}-${random_string.bucket_suffix.id}"
}