resource "aws_autoscaling_policy" "scale_up" {
  name                   = "csye6225-scale-up"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  autoscaling_group_name = aws_autoscaling_group.csye6225_asg.name
  cooldown               = 60
}

resource "aws_cloudwatch_metric_alarm" "cpu_high" {
  alarm_name          = "cpu_high_alarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Average"
  threshold           = 10
  alarm_description   = "Scale up if CPU > 10%"
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.csye6225_asg.name
  }
  alarm_actions = [aws_autoscaling_policy.scale_up.arn]
}

resource "aws_autoscaling_policy" "scale_down" {
  name                   = "csye6225-scale-down"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  autoscaling_group_name = aws_autoscaling_group.csye6225_asg.name
  cooldown               = 60
}

resource "aws_cloudwatch_metric_alarm" "cpu_low" {
  alarm_name          = "cpu_low_alarm"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Average"
  threshold           = 8
  alarm_description   = "Scale down if CPU < 8%"
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.csye6225_asg.name
  }
  alarm_actions = [aws_autoscaling_policy.scale_down.arn]
}
