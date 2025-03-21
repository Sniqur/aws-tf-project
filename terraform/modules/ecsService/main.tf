resource "aws_ecs_service" "ecs-service" {
  name            = "my-ecs-service"
  cluster         = var.cluster_id  
  task_definition = var.task_definition_arn  
  desired_count   = 1
  

  launch_type     = "FARGATE"
  network_configuration {
    
    subnets          = [var.private_subnet_id]  
    assign_public_ip = true               
    security_groups = [var.security_group_id]       
  }

  depends_on = [var.task_def_dependency]  # Ensure task definition is created first
}