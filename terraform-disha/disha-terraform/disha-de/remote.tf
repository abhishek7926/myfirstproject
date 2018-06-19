terraform {
  backend "s3" {
    bucket = "disha-de-states"
    region = "ap-south-1"
    encrypt="true"
    key="terraform.tfstate"
    lock_table = "terraform-remote-states-locking"
  }
}