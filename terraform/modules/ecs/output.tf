output "cluster_id" {
  value = aws_ecs_cluster.ecs.id
}

output "task_definition_arn" {
  value = aws_ecs_task_definition.task_def.arn
}

output "task_def_dependency" {
  value = aws_ecs_task_definition.task_def
}

output "container_name" {
  value = var.docker_container_name
}