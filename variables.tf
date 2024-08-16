variable "create_nat_gateway" {
  description = "Whether to create a NAT gateway"
  type        = bool
  default     = false
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR block for the VPC"
  type        = list(string)
  #   default     = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  description = "CIDR block for the VPC"
  type        = list(string)
  #   default     = "10.0.2.0/24"
}

variable "default_tags" {
  description = "Tags for the account"
  type        = map(any)
}

variable "project_name" {
  description = "Name of the Project"
  type        = string
}


variable "env" {
  description = "The name of the environment."
  type        = string
}

variable "terraform_provider_region" {
  description = "Region for all deployments"
  type        = string
}

variable "should_create_vpc" {
  description = "create vpc or use the default one"
  type        = string
}