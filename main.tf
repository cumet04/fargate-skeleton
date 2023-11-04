terraform {
  required_version = "1.6.3"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.24.0"
    }
  }

  backend "local" {
    path = ".terraform.tfstate"
  }
}

provider "aws" {
  region = "ap-northeast-1"

  default_tags {
    tags = {
      iacName = "${var.name}"
      iacRepo = "github.com/cumet04/fargate-skeleton"
    }
  }
}

variable "name" {
  type        = string
  description = "group name of resources"
}
