# Security Group for the Application Load Balancer
resource "aws_security_group" "project_alb_sg" {
  name        = var.alb_security_group_name
  description = "Security group for the Application Load Balancer"
  vpc_id      = aws_vpc.project_vpc.id  # Specify the VPC ID where the security group should be created

  # Allow inbound HTTP requests
  ingress {
    from_port   = var.http_server_port
    to_port     = var.http_server_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound requests
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create an Application Load Balancer
resource "aws_alb" "project_load_balancer" {
  name               = var.alb_name
  internal           = false
  load_balancer_type = "application"
  subnets            = [for subnet in aws_subnet.public_subnet : subnet.id]
  security_groups    = [aws_security_group.project_alb_sg.id]

  tags = {
    Name = "${var.prefix}-alb"
  }
}

# Create a Target Group for EC2 instances
resource "aws_lb_target_group" "ec2_target_group" {
  name                 = "${var.prefix}-EC2-Target-Group"
  port                 = var.http_server_port
  protocol             = "HTTP"
  vpc_id               = aws_vpc.project_vpc.id
  target_type          = "instance"
  deregistration_delay = 60  # Optional: Configure deregistration delay

  health_check {
    path                = "/"
    port                = var.http_server_port
    protocol            = "HTTP"
    interval            = 30  # Health check interval
    timeout             = 5   # Health check timeout
    healthy_threshold   = 2   # Healthy threshold count
    unhealthy_threshold = 2   # Unhealthy threshold count
  }
}

# Attach EC2 instances to the target group
resource "aws_lb_target_group_attachment" "ec2_target_attachment" {
  count            = length(aws_instance.nginx_instance)
  target_group_arn = aws_lb_target_group.ec2_target_group.arn
  target_id        = aws_instance.nginx_instance[count.index].id

  depends_on = [aws_lb_target_group.ec2_target_group]
}

# Create a Listener for HTTP traffic
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_alb.project_load_balancer.arn
  port              = var.http_server_port
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ec2_target_group.arn
  }
}
