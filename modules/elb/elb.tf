resource "aws_lb" "my_alb" {
  name               = "${var.env}-${var.project_name}-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.sg_id]
  subnets            = var.public_subnet_ids

  enable_deletion_protection = false
  idle_timeout               = 60

  tags = merge(var.default_tags, {
    Name        = "${var.env}-${var.project_name}-lb"
    description = "Load Balancer for ${var.env}-${var.project_name}"
  })
}
