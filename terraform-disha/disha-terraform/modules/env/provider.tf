provider "aws" {
  region = "${var.aws_region}"
  profile = "${var.provider_profile}"
}

provider "aws" {
  alias  = "aws_ses"
  region = "us-east-1"
  profile = "${var.provider_profile}"
}
