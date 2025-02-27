resource "aws_instance" "csye6225_app_instance" {
  ami                         = var.custom_ami_id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.public[0].id
  vpc_security_group_ids      = [aws_security_group.csye6225_app_sg.id]
  associate_public_ip_address = true
  key_name                    = var.key_name

  # Disable termination protection
  disable_api_termination = false

  root_block_device {
    volume_size           = 25
    volume_type           = "gp2"
    delete_on_termination = true
  }

  tags = {
    Name = "csye6225-app-instance"
  }
}
