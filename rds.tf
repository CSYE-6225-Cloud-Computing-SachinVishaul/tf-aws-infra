#############################
# RDS Instance Setup
#############################

# 1. Create a DB Subnet Group using your private subnets
resource "aws_db_subnet_group" "csye6225_db_subnet_group" {
  name       = "csye6225-db-subnet-group"
  subnet_ids = aws_subnet.private[*].id

  tags = {
    Name = "csye6225-db-subnet-group"
  }
}

# 2. Create an RDS Security Group that allows MySQL traffic only from your app security group
resource "aws_security_group" "csye6225_db_sg" {
  name        = "csye6225-db-sg"
  description = "Security group for CSYE6225 RDS instance"
  vpc_id      = aws_vpc.main.id

  ingress {
    description     = "Allow MySQL access from app instance SG"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.csye6225_app_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "csye6225-db-sg"
  }
}

# 3. Create a Custom RDS Parameter Group (example for MySQL 8.0)
resource "aws_db_parameter_group" "csye6225_db_pg" {
  name        = "csye6225-db-pg"
  family      = "mysql8.0"
  description = "Custom parameter group for csye6225 RDS instance"

  parameter {
    name  = "character_set_server"
    value = "utf8mb4"
  }

  tags = {
    Name = "csye6225-db-pg"
  }
}

# 4. Create the RDS Instance using the above resources
resource "aws_db_instance" "csye6225_rds" {
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t3.micro" # Cheapest available instance type
  identifier             = "csye6225"
  username               = "csye6225"
  password               = var.db_master_password
  db_name                = "csye6225"
  parameter_group_name   = aws_db_parameter_group.csye6225_db_pg.name
  db_subnet_group_name   = aws_db_subnet_group.csye6225_db_subnet_group.name
  vpc_security_group_ids = [aws_security_group.csye6225_db_sg.id]
  multi_az               = false
  publicly_accessible    = false
  skip_final_snapshot    = true
  deletion_protection    = false

  tags = {
    Name = "csye6225-rds"
  }
}
