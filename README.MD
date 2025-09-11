# Terraform Three-Tier Architecture on AWS

This project showcases how I deployed a highly available **three-tier architecture on AWS** using **Terraform (Infrastructure as Code).**
It demonstrates **modular design, scalability, and security** while following AWS best practices.

---

## 🌐 Project Overview
The project automates deployment of a three-tier architecture: **Web → Application → Database.**
Terraform modules are used for **reusability** and **cleaner code**, implementing **network isolation**, load balancing, and secure database access.**

---
## 🌐Project Structure

terraform-three-tier/
├─ modules/
│  ├─ vpc/            # main.tf, variables.tf, outputs.tf, etc.
│  ├─ ec2/            # main.tf, variables.tf, outputs.tf, etc.
│  ├─ rds/            # main.tf, variables.tf, outputs.tf, etc.
│  ├─ alb/            # main.tf, variables.tf, outputs.tf, etc.
│  ├─ security_groups/ # main.tf, variables.tf, outputs.tf, etc.
│  └─ cloudfront/     # main.tf, variables.tf, outputs.tf, etc.
├─ main.tf
├─ variables.tf
├─ provider.tf
└─ terraform.tfvars

## 🚀Architecture Overview
This project implements a highly available three-tier architecture on AWS, designed for scalability, security, and modularity.

### 1️⃣ High-Level Architecture
	Web Layer: EC2 instances in public subnets behind an Application Load Balancer (ALB). Handles all incoming traffic.
	Application Layer: EC2 instances in private subnets, accessible only through the ALB or a bastion host. Processes business logic.
	Database Layer: RDS instance in a private subnet, secured with security groups allowing access only from the application layer.

### 2️⃣ Network & Traffic Flow
	VPC: Contains public and private subnets across multiple Availability Zones.
	Internet Gateway & NAT Gateway: Provides controlled internet access.
	CloudFront: Delivers content globally with caching and HTTPS.	
	Traffic Flow:
		**User → CloudFront → ALB → Web/App EC2 → RDS (if needed)**

### 3️⃣ Security & Access
	Each layer has its own Security Group.
	Web servers are accessible from the internet; application servers and database are isolated in private subnets.
	Bastion host provides secure admin access to private resources.

### 4️⃣ Scalability & Cost Optimization
	Scalable: ALB supports auto-scaling of EC2 instances; RDS can scale vertically or via read replicas; CloudFront handles global caching.
	Cost-Optimized: Uses micro instances and default CloudFront/ALB domains to minimize expenses during demo/testing.

<img width="1105" height="461" alt="Architecture" src="https://github.com/user-attachments/assets/8eff6898-aa9a-4520-9506-8383b4a86d23" />

---

## ⚙️ Implementation Steps

### Step 1: Setup Terraform Project
Created separate modules for VPC, Security Groups, EC2, RDS,Cloudfront and Loadbalancer.
Defined variables and outputs for flexibility.

Example: Module call in main.tf
module "ec2" {
  source = "./EC2"
  public_security_group_ids = module.security-group.web-sg-id
  pub1_subnet_id = module.vpc.pub1_subnet_id
  pub2_subnet_id = module.vpc.pub2_subnet_id
  private_security_group_ids = module.security-group.app-sg-id
  prv1_subnet_id = module.vpc.prv1_subnet_id
  prv2_subnet_id = module.vpc.prv2_subnet_id
  db-sg = module.security-group.db-sg-id
  
}

<img width="1270" height="815" alt="Screenshot-website-code" src="https://github.com/user-attachments/assets/6b39da74-5f85-4d3a-98b7-40c9ed609104" />


### Step 2: Deploy Networking Layer
Provisioned VPC, subnets, Internet Gateway, and NAT Gateway.
Configured route tables for controlled traffic flow.

Example: Public Subnet
resource "aws_subnet" "pub1" {

    vpc_id = aws_vpc.vpc1.id
    cidr_block = "10.0.0.0/18"
    availability_zone = "ap-south-1a"
    tags = {
      Name = "Public_sub1"
    }
}
 
<img width="1114" height="701" alt=" S3 bucket configured for static website" src="https://github.com/user-attachments/assets/9e3f0ec6-e88f-433e-b798-45741a6c5a0e" />


### Step 3: Configure Security
Created Security Groups for ALB, Web layer,Application layer and Database layer.

Example: Security Group
resource "aws_security_group" "websg"{
    name = "web-security-group"
    description = "allow ssh and http"
    vpc_id = var.vpc_id
}

resource "aws_vpc_security_group_ingress_rule" "inbound2" {
    security_group_id = aws_security_group.websg.id
    from_port = "80"
    #cidr_ipv4 = "0.0.0.0/0"
    referenced_security_group_id = aws_security_group.load.id
    ip_protocol = "tcp"
    to_port = "80"
  
}
<img width="829" height="511" alt="Uploaded the website file to the S3 bucket" src="https://github.com/user-attachments/assets/a66eaf67-3c13-456f-b283-f3185de25bad" />

### Step 4:Web,Application & Database Layer
Launched EC2 instances in public subnets behind an Application Load Balancer (ALB).
Launched EC2 instances in private subnets, accessible only through a bastion host.
Deployed an RDS instance in the database subnet, configured for secure access via the bastion host.

Example: EC2 Instance
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
    user_data = file("./EC2/userdata/apache.sh")
    tags = {
      Name = "Bastion-Host1"
    }
}

### Step 5: Testing web and application layer
Verified application accessibility through the Web Layer.
Confirmed that the database is accessible only from the Application Layer (secure connectivity).
Tested application access using the ALB DNS endpoint.
Validated application delivery via the CloudFront endpoint.
(4 ss of verification)

---

## 🔧 Challenges & Lessons Learned
- **Managed state files securely and learned the importance of remote state backends.
- **Debugged module dependencies to ensure correct resource creation order.
- **Learned to use tfvars files for storing sensitive details securely.
- **Adopted modular code best practices for better reusability and scalability.
---

## 💰 Cost Optimization
- **Used t3.micro EC2 and RDS t3.micro instances to minimize costs in testing.
- **Avoided extra expenses by using CloudFront’s default domain and skipping SSL certificates during the demo phase.
- **Designed the architecture to be lightweight yet scalable:
	- **Scalable → ALB supports adding/removing EC2s, CloudFront handles global caching, RDS supports
		       scaling vertically and with read replicas.
	- **Lightweight → Minimal resources (micro instances, no paid services) to keep bills under control.
---

## 🚀 Future Enhancements
To make the setup more production-ready:

- **Auto Scaling Groups – Automatically adjust app servers based on traffic.
- **Terraform Remote Backend – Use S3 + DynamoDB for secure and collaborative state management.
- **CloudWatch Monitoring & Alarms – Enable proactive monitoring and alerts.
- **CI/CD Pipeline – Use GitHub Actions + Terraform Cloud for automated deployments.
- **SSL Certificate (ACM) – Secure endpoints with HTTPS and a custom domain.
- **AWS WAF (Web Application Firewall) – Protect from common web exploits.
- **Custom Domain Integration – Map CloudFront to a Route 53 domain for better accessibility.

---

## 🔗 Demo

- **🌐 Application Access → Accessible via ALB DNS endpoint (d3d0y3lhl1dt40.cloudfront.net)
- **📂 Terraform Project Code → Available in this repository

- **📝 Note: The application is a simple Apache web server. The focus of this project is on designing and deploying a scalable and secure cloud infrastructure using AWS services and Terraform.

<img width="842" height="860" alt="Website-test" src="https://github.com/user-attachments/assets/c262a210-2245-4289-bfb3-1be7ab95dec9" />

