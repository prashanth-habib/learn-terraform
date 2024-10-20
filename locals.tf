locals {
  common_tags = {
    common       = var.company
    project      = "${var.company}-${var.project}"
    billing_code = var.billing_code
  }
}