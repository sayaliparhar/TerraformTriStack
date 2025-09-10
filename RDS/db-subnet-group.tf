resource "aws_db_subnet_group" "subnetgroup" {
    name = "db-subnet-group"
    subnet_ids = [ 
        var.prv1_subnet_id,
        var.prv2_subnet_id]
    tags = {
      Name = "DB-subnet-group"
    }
  
}