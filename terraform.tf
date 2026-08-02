# proivder

terraform {

required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.56.0"
    }
  }
  #backend "s3" {
   #bucket         = "terraform-state-bucket"
    #key            = "terraform.tfstate"
    #region         = "us-east-1"
    #dynamodb_table = "terraform-state-lock"
 # }
}
