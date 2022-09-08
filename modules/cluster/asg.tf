data "aws_ami" "amazon_linux" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn-ami*amazon-ecs-optimized"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["amazon", "self"]
}

resource "aws_security_group" "ec2-sg" {
  name        = var.ec2-sg-name
  description = var.ec2-sg-description
  vpc_id      = aws_vpc.main.id
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Sec-Group"
  }
}

resource "aws_launch_template" "ltemplate" {
  name                   = var.ltemplate-name
  image_id               = data.aws_ami.amazon_linux.id
  instance_type          = var.ltemplate-instance-type
  iam_instance_profile {
    name = aws_iam_instance_profile.ecs_service_role.name
  }       
  key_name                    = var.key_name
  network_interfaces {
    associate_public_ip_address = true
    security_groups = [aws_security_group.ec2-sg.id]
  }
  user_data = "${base64encode(<<EOF
    #! /bin/bash
    sudo apt-get update
    sudo echo "ECS_CLUSTER=${var.cluster_name}" >> /etc/ecs/ecs.config
  EOF
  )}"
}

resource "aws_autoscaling_group" "asg" {
  name                      = var.asg-name
  min_size                  = 1
  max_size                  = 3
  desired_capacity          = 2
  health_check_type         = "ELB"
  health_check_grace_period = 300
  vpc_zone_identifier       = [for subnet in aws_subnet.public_subnets : subnet.id]

  target_group_arns     = [aws_lb_target_group.lb_target_group.arn]
  protect_from_scale_in = true
  lifecycle {
    create_before_destroy = true
  }

  launch_template {
    id = aws_launch_template.ltemplate.id
    version = "$Latest"
  }
}
