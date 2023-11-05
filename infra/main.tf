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

output "subnet_id" {
  value = aws_subnet.public.id
}

output "log_group_name" {
  value = aws_cloudwatch_log_group.ecs_task_log_group.name
}

output "task_execution_role_arn" {
  value = aws_iam_role.ecs_task_execution_role.arn
}

output "security_group_id" {
  value = aws_security_group.ecs_task_sg.id
}

output "repository_url" {
  value = aws_ecr_repository.main.repository_url
}
