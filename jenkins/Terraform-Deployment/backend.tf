terraform {
  backend "s3" {
    bucket         = "diana-terraform-state-bucket-robotdreams"
    key            = "envs/jenkins/terraform.tfstate"
    region         = "eu-north-1"
    encrypt        = true
  }
}
