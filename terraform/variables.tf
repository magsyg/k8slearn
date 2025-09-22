variable "region" {
  type    = string
  default = "eu-central-1"
}

variable "prefix" {
  type    = string
  default = "k8slearn"
}

variable "vpc_cidr" {
  type    = string
  default = "10.10.0.0/23"
}

variable "public_cidr" {
  type    = string
  default = "10.10.1.0/24"
}