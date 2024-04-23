variable "region" {
    description = "AWS Region to deploy to"
    default = "us-east-2"
    type    = string
}


variable "ami_id" {
  default = "ami-0b8b44ec9a8f90422"
  type    = string
}

variable "instance_type" {
  default = "t2.large"
  type    = string
}

variable "key_name" {
  default = "project-cstore"
  type    = string
}

variable "acl" {
  default = "private"
  type    = string
}