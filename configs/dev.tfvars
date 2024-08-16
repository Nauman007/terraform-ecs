default_tags = {
  "Department" : "DevOps",
  "PrimaryContact" : "test@example.com",
  "Terraform" : "True",
  "ProjectName" : "Test-Sample",
  "Environment" : "dev"
}

terraform_provider_region = "us-east-1"

project_name = "Test-Sample"
env          = "development"

should_create_vpc = false

vpc_cidr            = "10.0.0.0/16"
public_subnet_cidr  = ["10.0.1.0/24"]
private_subnet_cidr = ["10.0.2.0/24"]

create_nat_gateway = false

