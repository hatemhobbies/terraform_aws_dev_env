terraform {

  required_providers {
    aws = {
    source  = "hashicorp/aws"
    version = "~> 3.27"
    }
  }
  required_version = ">= 0.14.9"
}

provider "aws" {
  region                = var.aws_region
}

# Sends your public key to the instance
resource "aws_key_pair" "k8s" {
  key_name   = "k8s"
  public_key = file(var.PUBLIC_KEY_PATH)
}


resource "aws_instance" "developer-env" {
  ami           = "${data.aws_ami.ubuntu.id}"
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.capstone-developer-sg.id]
  associate_public_ip_address = true
  key_name = "${aws_key_pair.k8s.key_name}"
  root_block_device {
    volume_type = "gp2"
    volume_size = "30"
    delete_on_termination = false
}



  tags = {
    Name = "Capstone-Project-Developer-Env"
  }
}


resource "null_resource" "install-tools" {

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file(var.PRIV_KEY_PATH)
    host        = "${aws_instance.developer-env.public_ip}"
  }

  provisioner "remote-exec" {
    inline = [ "mkdir -p /home/ubuntu/install_scripts" ]
  }

  provisioner "file" {
    source      = "./install_tools.sh"
    destination = "/home/ubuntu/install_scripts/install_tools.sh"
  }

  provisioner "file" {
    source      = "~/.ssh/k8s_rsa"
    destination = "/home/ubuntu/.ssh/k8s_rsa"
  }

 provisioner "file" {
    source      = "~/.ssh/k8s_rsa.pub"
    destination = "/home/ubuntu/.ssh/k8s_rsa.pub"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /home/ubuntu/install_scripts/install_tools.sh",
      "/home/ubuntu/install_scripts/install_tools.sh"
    ]
  }
}

output "IPAddress" {
  value = "${aws_instance.developer-env.public_ip}"
}



