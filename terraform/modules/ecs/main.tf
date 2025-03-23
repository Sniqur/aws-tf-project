resource "aws_ecs_cluster" "ecs" {
  name = var.cluster_name
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
    "name": "${var.docker_container_name}",
    "image": "${var.docker_image}",
    "cpu": 1024,
    "memory": 2048,
    "essential": true,
    "portMappings": [
      {
        "containerPort": ${var.container_port}
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



