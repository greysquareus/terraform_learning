terraform {
  backend "s3" {
    bucket         = "THE_NAME_OF_THE_STATE_BUCKET"
    key            = "some_environment/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    kms_key_id     = "THE_ID_OF_THE_KMS_KEY"
    dynamodb_table = "THE_ID_OF_THE_DYNAMODB_TABLE"
  }
  
  required_version = "1.14.8"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.42.0"
    }

    google = {
      source  = "hashicorp/google"
      version = "7.29.0"
    }

    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.70.0"
    }

    experiments  = ["<feature-name>"]
  }
}