terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.83.0"
    }
  }
}

module "ec2" {
  source      = "./ec2"
  name_prefix = var.prefix
  #control_plane_sg_id = module.security.control_plane_sg.id
  #subnet_id = module.network.vpc_public_subnet.id
}

/*
module "network" {
    source = "./network"
    name_prefix = var.prefix
    public_cidr = var.public_cidr
    vpc_cidrblock = var.vpc_cidr
}
module "security" {
    source = "./security_groups"
    name_prefix = var.prefix
    main_vpc_id = module.network.main_vpc_id
}
*/


terraform {
  backend "s3" {
    bucket       = "k8slearn-bucket"
    key          = "terraform.state"
    region       = "eu-central-1"
    use_lockfile = true
  }
}

