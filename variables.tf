variable "aws_region" {
  description = "The AWS region to deploy the EC2 instance in."
  default   = "us-east-2"
}


variable "instance_type" {
  description = "instance type for ec2"
  default   =  "t2.micro"
}


variable "PUBLIC_KEY_PATH" {
  type = string
  default = "~/.ssh/k8s_rsa.pub"
}

variable "PRIV_KEY_PATH" {
  type = string
  default = "~/.ssh/k8s_rsa"
}