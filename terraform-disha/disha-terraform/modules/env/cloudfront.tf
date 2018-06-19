module "disha_web_cloudfront" {
  source = "../cloudfront"
  bucket_domain_name = "${var.disha_web_bucket_name}.s3.amazonaws.com"
  bucket_name = "${var.disha_web_bucket_name}"

}

module "disha_cms_wordpress_cloudfront" {
  source = "../cloudfront"
  bucket_domain_name = "${var.cms_wordpress_bucket_name}.s3.amazonaws.com"
  bucket_name = "${var.cms_wordpress_bucket_name}"

}