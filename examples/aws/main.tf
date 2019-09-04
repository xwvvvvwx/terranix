# Configure the AWS Provider
provider "aws" {
  region  = "eu-central-1"
}

resource "aws_security_group" "nixos" {
  name = "allow-all-sg"

  ingress {
    cidr_blocks = [ "0.0.0.0/0" ]
    from_port = 22
    to_port = 22
    protocol = "tcp"
  }

  ingress {
    cidr_blocks = [ "0.0.0.0/0" ]
    from_port = 80
    to_port = 80
    protocol = "tcp"
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

module "aws-1" {
  source  = "./aws_nixos"
  name    = "aws-1"
  sg = "${aws_security_group.nixos.name}"
  authorized_keys = [ "${file("${path.module}/../ssh_key.pub")}" ]
}