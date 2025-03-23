resource "aws_ecs_service" "ecs-service" {
  name            = var.ecs_service_name
  cluster         = var.cluster_id  
  task_definition = var.task_definition_arn  
  desired_count   = 1
  

  launch_type     = "FARGATE"

  load_balancer {
  target_group_arn = var.target_group_id
  container_name   = var.container_name
  container_port   = var.container_port
  }

  network_configuration {
    
    subnets          = [var.private_subnet_id]  
    assign_public_ip = true               
    security_groups = [var.security_group_id]       
  }

  depends_on = [var.task_def_dependency]  # Ensure task definition is created first
}