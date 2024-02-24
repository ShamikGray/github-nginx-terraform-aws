# provider.tf

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}


terraform {
  backend "s3" {
    bucket  = "project-terraform-state-backup"
    key     = "tfstate"
    region  = "ap-southeast-1" # var not allowed
  }
}


#terraform {
 ##  bucket         = "project-terraform-state-backup"
   # key            = "tfstate"
    #region         = "ap-southeast-1"
   # encrypt        = true
   # dynamodb_table = "terraform_locks"
  #}
#}