resource "aws_instance" "bastion-host" {
    instance_type = "t3.micro"
    ami = var.ami_id
    subnet_id = var.pub1_subnet_id
    associate_public_ip_address = true
    key_name = aws_key_pair.key.id
    vpc_security_group_ids = [var.public_security_group_ids]
    root_block_device {
      volume_size = 8
      volume_type = "gp3"
    }
    user_data = file("./Modules/EC2/userdata/apache.sh")
    tags = {
      Name = "Bastion-Host1"
    }

    lifecycle {
      prevent_destroy = false
    }

  
}

