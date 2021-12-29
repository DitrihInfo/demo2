#---------------------------------------------------
# Setup  Varible
#---------------------------------------------------

variable "project" {
  description = "The project names to use for unique resource naming"
  default     = "Demo2"
  type        = string
}

variable "region" {
  description = "AWS region"
  default = "ca-central-1"
  type        = string
}
variable "amazonkey" {
  description = "amazon ssh key"
  default = "ca-cetral-1-key"
  type        = string
}
variable "instance_type" {
  description = "Enter Instance Type"
  type        = string
  default     = "t2.micro"
}
variable "ami" {
  description = "Enter Instance Type"
  type        = string
  default     = "ami-04a6c66cacdef1be5"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

