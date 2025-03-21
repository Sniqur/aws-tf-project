resource "aws_ecs_cluster" "ecs" {
  name = "my-cluster"
}

resource "aws_ecs_cluster_capacity_providers" "ecs_provider" {
  cluster_name = aws_ecs_cluster.ecs.name

  capacity_providers = ["FARGATE"]

  default_capacity_provider_strategy {
    base              = 1
    weight            = 100
    capacity_provider = "FARGATE"
  }
}

resource "aws_ecs_task_definition" "task_def" {

  family = var.task_family
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 1024
  memory                   = 2048
  task_role_arn = var.role_arn
  container_definitions = <<TASK_DEFINITION
[
  {
    "name": "testaws",
    "image": "steeve05/aws:latest",
    "cpu": 1024,
    "memory": 2048,
    "essential": true,
    "portMappings": [
      {
        "containerPort": 3000
      }
    ]
  }
]
TASK_DEFINITION

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
    
  }
}

















# resource "aws_iam_role" "ecs_task_role" {
#   name = "ecs-task-role"
#   assume_role_policy = jsonencode({
#     "Version": "2012-10-17",
#     "Statement": [
#         {
#             "Sid": "ECSAssumeRole",
#             "Effect": "Allow",
#             "Principal": {
#                 "Service": "ecs-tasks.amazonaws.com"
#             },
#             "Action": "sts:AssumeRole"
#         }
#     ]
#   })
# }

# # Permissions policy that allows ECS task to access S3
# resource "aws_iam_policy" "ecs_task_policy" {
#   name        = "AmazonS3ReadOnlyAccess"
#   description = "Policy to allow ECS task to access S3"

#   policy = jsonencode({
#     "Version": "2012-10-17",
#     "Statement": [
#         {
#             "Effect": "Allow",
#             "Action": [
#                 "s3:Get*"
#             ],
#             "Resource": "arn:aws:s3:::aws-tf-back/*"
#         }
#     ]
#   })
# }

# resource "aws_iam_role_policy_attachment" "role-attach" {
#     role = aws_iam_role.ecs_task_role.name
#     policy_arn = aws_iam_policy.ecs_task_policy.arn
  
# }