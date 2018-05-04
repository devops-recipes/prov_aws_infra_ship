# main creds for AWS connection
variable "accessKey" {
  description = "AWS access key"
}

variable "secretKey" {
  description = "AWS secert access key"
}

variable "region" {
  description = "AWS region"
  default = "us-east-1"
}

variable "avl_zone" {
  description = "availability zone used for the beta"
  default = "us-east-1b"
}

# this is a keyName for key pairs
variable "aws_key_name" {
  description = "Key Pair Name used to login to the box"
}

# all variables related to VPC
variable "install_version" {
  description = "version of the infra"
}

variable "vpc_id" {
  description = "VPC ID where everything will be created"
}


variable "ig_id" {
  description = "Internet Gateway ID opf the VPC"
}

variable "ship_sn_cidr" {
  description = "Public 0.0 CIDR for externally accesible subnet"
}

variable "in_type_cp" {
  description = "AWS Instance type for control plane server"
}

variable "in_type_bp" {
  description = "AWS Instance type for running builds"
}

variable "ami_us_east_1_ubuntu1604"{
  description = "AWS AMI for us-east-1 Ubuntu 16.04"
}

variable "acm_cert_arn"{
  description = "acm cert arn"
}
