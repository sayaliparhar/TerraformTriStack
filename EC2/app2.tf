resource "aws_instance" "app-server2" {
  instance_type = "t3.micro"
  ami = "ami-02d26659fd82cf299"
  key_name = aws_key_pair.key.id
  subnet_id = var.prv2_subnet_id
  vpc_security_group_ids = [var.private_security_group_ids]
  associate_public_ip_address = false
  root_block_device {
    volume_size = 8
    volume_type = "gp3"
  }
  user_data = file("./EC2/userdata/apache.sh")
  tags = {
    Name = "Application-server2"
  }

  lifecycle {
    prevent_destroy = false
  }
}