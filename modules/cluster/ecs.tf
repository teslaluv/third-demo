resource "aws_ecs_cluster" "web-cluster" {
  name = var.cluster_name
}

resource "aws_ecs_cluster_capacity_providers" "example" {
  cluster_name = aws_ecs_cluster.web-cluster.name
  capacity_providers = [aws_ecs_capacity_provider.test.name]
}

resource "aws_ecs_capacity_provider" "test" {
  name = var.ecs_capacity_provider_name
  auto_scaling_group_provider {
    auto_scaling_group_arn         = aws_autoscaling_group.asg.arn
    managed_termination_protection = "ENABLED"

    managed_scaling {
      status          = "ENABLED"
      target_capacity = 85
    }
  }
}

data "template_file" "flask_app" {
  template = file(var.taskdef_template)

  vars = {
    app_image      = var.app_image
    app_port       = var.app_port
    number_cpu    = var.number_cpu
    number_memory = var.number_memory
    aws_region     = var.aws_region
    env            = var.environment
    app_name       = var.app_name
    # image_tag      = var.image_tag
  }
}

resource "aws_ecs_task_definition" "task-definition-test" {
  family                = var.task_definition_family
  container_definitions    = data.template_file.flask_app.rendered
  network_mode          = var.task_definition_network_mode
}

resource "aws_ecs_service" "service" {
  name            = var.ecs-service-name
  cluster         = aws_ecs_cluster.web-cluster.id
  task_definition = aws_ecs_task_definition.task-definition-test.arn
  desired_count   = 2

  ordered_placement_strategy {
    type  = "binpack"
    field = "cpu"
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.lb_target_group.arn
    container_name   = var.ecs-container-name
    container_port   = var.ecs-container-port
  }
  # Optional: Allow external changes without Terraform plan difference(for example ASG)
  lifecycle {
    ignore_changes = [desired_count]
  }
  launch_type = "EC2"
  depends_on  = [aws_lb_listener.web-listener]
}

resource "aws_cloudwatch_log_group" "log_group" {
  name = "/ecs/frontend-container"
}
