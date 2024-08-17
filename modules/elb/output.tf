output "target_group_arn" {
  value = aws_lb_target_group.http_target_group.arn
}

output "load_balancer_dns_name" {
  value = aws_lb.my_alb.dns_name
}