resource "aws_instance" "db-server" {
  instance_type = "t3.micro"
  ami = var.ami_id
  key_name = aws_key_pair.key.id
  subnet_id = var.prv1_subnet_id
  vpc_security_group_ids = [var.db-sg]
  associate_public_ip_address = false
  root_block_device {
    volume_size = 8
    volume_type = "gp3"
  }
  user_data = file("./Modules/EC2/userdata/mysql.sh")
  tags = {
    Name = "Database-server"
  }

  lifecycle {
    prevent_destroy = false
  }
}