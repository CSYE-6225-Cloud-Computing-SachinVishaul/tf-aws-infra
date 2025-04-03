resource "aws_autoscaling_group" "csye6225_asg" {
  name_prefix               = "csye6225_asg_"
  max_size                  = 5
  min_size                  = 3
  desired_capacity          = 3 # Ensure this is between min and max sizes
  health_check_grace_period = 300
  health_check_type         = "EC2"
  vpc_zone_identifier       = aws_subnet.public[*].id

  launch_template {
    id      = aws_launch_template.csye6225_asg.id
    version = "$Latest"
  }

  target_group_arns = [aws_lb_target_group.csye6225_tg.arn]

  tag {
    key                 = "AutoScalingGroup"
    value               = "csye6225_asg"
    propagate_at_launch = true
  }
}
