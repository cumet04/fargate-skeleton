resource "aws_ecs_cluster" "main" {
  name = "fargate-skeleton_${var.name}"
}

resource "aws_ecr_repository" "main" {
  name = "fargate-skeleton_${var.name}"
}

resource "aws_iam_role" "ecs_task_execution_role" {
  name = "fargate-skeleton_${var.name}_task_execution_role"

  managed_policy_arns = ["arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"]
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_security_group" "ecs_task_sg" {
  name   = "fargate-skeleton_${var.name}-main"
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_cloudwatch_log_group" "ecs_task_log_group" {
  name              = "/ecs/fargate-skeleton_${var.name}-main"
  retention_in_days = 7
}
