resource "aws_instance" "bastionhost2" {
    instance_type = "t3.micro"
    ami = var.ami_id
    key_name = aws_key_pair.key.id
    associate_public_ip_address = true
    subnet_id = var.pub2_subnet_id
    vpc_security_group_ids = [var.public_security_group_ids]
    user_data = file("./Modules/EC2/userdata/apache.sh")
    root_block_device {
      volume_size = 8
      volume_type = "gp3"
    }
    tags = {
      Name = "Bastion_host2"
    }

    lifecycle {
      prevent_destroy = false
    }
  
}