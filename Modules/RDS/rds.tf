resource "aws_db_instance" "db-1" {
  engine = "mysql"
  engine_version = "8.0"
  instance_class = "db.t3.micro"
  db_name = "myprojectdb"
  username = "admin"
  password = "var.db_password"
  allocated_storage = 10
  db_subnet_group_name = aws_db_subnet_group.subnetgroup.name
  vpc_security_group_ids = [var.db-security-group]
  publicly_accessible = false
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
  tags = {
    Name = "Project-DB"
  }
}