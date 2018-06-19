terraform {
  backend "s3" {
    bucket = "disha-website-states"
    region = "ap-northeast-1"
    encrypt="true"
    key="terraform.tfstate"
    lock_table = "terraform-remote-states-locking"
  }
}
