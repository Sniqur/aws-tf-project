terraform {
  backend "s3" {
    bucket = "aws-tf-back"
    key    = "states/dev-tf/terraform.tfstate"
    region = "us-east-1"
  }
}