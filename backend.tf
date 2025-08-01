terraform {
  backend "s3" {
    bucket = "cicd-terraform-eks-spatika"
    key = "notification-system/terraform.tfstate"
    region = "ap-south-1"
  }
}