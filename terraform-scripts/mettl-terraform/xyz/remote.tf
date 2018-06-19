terraform {
  backend "s3" {
    bucket = "xyz-states"
    region = "eu-central-1"
    encrypt="true"
    key="terraform.tfstate"
    lock_table = "terraform-remote-states-locking"
  }
}


