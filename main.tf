terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.9.0"
    }
  }
}

module "vpc" {
    source = "./Modules/VPC"

}

module "security-group" {
    source = "./Modules/Security_Group"
    vpc_id = module.vpc.vpc_id
    cloudfront_prefix_list_id  = var.cloudfront_prefix_list_id
}


module "ec2" {
  source = "./Modules/EC2"
  public_security_group_ids = module.security-group.web-sg-id
  pub1_subnet_id = module.vpc.pub1_subnet_id
  pub2_subnet_id = module.vpc.pub2_subnet_id
  private_security_group_ids = module.security-group.app-sg-id
  prv1_subnet_id = module.vpc.prv1_subnet_id
  prv2_subnet_id = module.vpc.prv2_subnet_id
  db-sg = module.security-group.db-sg-id
  
}

module "rds" {
  source = "./Modules/RDS"
  db-security-group = module.security-group.db-sg-id
  prv1_subnet_id = module.vpc.prv1_subnet_id
  prv2_subnet_id = module.vpc.prv2_subnet_id
  db_password = var.db_password
}

module "alb" {
  source = "./Modules/ALB"
  vpc_id = module.vpc.vpc_id
  load_sg = module.security-group.load-sg
  web_instance = module.ec2.web1
  pub1_id = module.vpc.pub1_subnet_id
  pub2_id = module.vpc.pub2_subnet_id
}

module "cloudfront" {
  source = "./Modules/CloudFront"
  lb_dns = module.alb.lb-dns
}