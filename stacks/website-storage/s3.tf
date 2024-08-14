module "website-storage" {
  source = "../../modules/aws-s3-website-bucket"

  environment = var.environment
  tags        = var.tags
}
