provider "aws" {
  region = "us-east-2"

}

data "aws_ami" "amazon-linux" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["*ubuntu-jammy-22.04*"]

  }
}

module "prod-webservers" {
  source        = "git::https://github.com/sandeepckumar/terraform-modules//services/webserver-cluster?ref=v1.0.5"
  instance-type = "t2.medium"
  ami           = data.aws_ami.amazon-linux.id
  env           = "prod"
}

