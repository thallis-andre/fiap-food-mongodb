terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }

    mongodbatlas = {
      source  = "mongodb/mongodbatlas"
      version = "~> 1.21"

    }
  }

  backend "s3" {
    bucket = "fiap-f4-soat10"
    key    = "global/s3/mongodb.tfstate"
    region = "us-east-1"
  }
}
