data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "control_plane" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.medium"

  subnet_id     = var.subnet_id
  security_groups = [var.control_plane_sg_id]
  tags = {
    Name = "${var.name_prefix}-control-plane"
  }
  /*
   user_data = file("${path.module}/k8scontrolPlaneSetup")

    provisioner "remote-exec" {
    inline = [
      "sudo bash k8scontrolPlaneSetup",
    ]
    }*/
}