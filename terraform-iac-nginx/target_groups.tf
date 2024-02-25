# Create a target group for the EC2 instances
#resource "aws_lb_target_group" "ec2_target_group" {
 # name                 = "${var.prefix}-EC2-Target-Group"
#  port                 = var.http_server_port
#  protocol             = "HTTP"
#  vpc_id               = data.aws_vpc.default.id
#  target_type          = "instance"
#  deregistration_delay = 60  # Optional: Configure deregistration delay
#
#  health_check {
#    path                = "/"
#    port                = var.http_server_port
#    protocol            = "HTTP"
#    interval            = 30  # Health check interval
#    timeout             = 5   # Health check timeout
#    healthy_threshold   = 2   # Healthy threshold count
#    unhealthy_threshold = 2   # Unhealthy threshold count
#  }
#}
#
## Attach EC2 instances to the target group
#resource "aws_lb_target_group_attachment" "ec2_target_attachment" {
#  count            = length(aws_instance.nginx_instance)
#  target_group_arn = aws_lb_target_group.ec2_target_group.arn
#  target_id        = aws_instance.nginx_instance[count.index].id
#
#  depends_on = [aws_lb_target_group.ec2_target_group]
#}
