provider "aws" {
  region = "us-east-1"
}

resource "aws_key_pair" "key_pair" {
  key_name   = "id_rsa.pub"
  public_key = file("${path.module}/deploy_key.pub")
}

resource "aws_instance" "provisioning_host" {
  ami           = var.ami_id
  instance_type = "t2.micro"
  key_name      = aws_key_pair.key_pair.key_name
  security_groups = [aws_security_group.aws_sec_group.name]
  associate_public_ip_address = true

  user_data = file("./cloud-init.sh")

  tags = {
    Name        = "tf-demo-terraform-instance"
    Environment = "dev"
  }
}

resource "aws_security_group" "aws_sec_group" {
    name = "tf-demo-terraform-sec-group"
    description = "Allow SSH and HTTP traffic"

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks =  ["0.0.0.0/0"]
    }

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }


}

