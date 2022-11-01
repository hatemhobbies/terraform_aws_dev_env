# terraform_aws_dev_env

Pre requisite 
0) you must configure the config and credentials in ~/.aws
config file sample

[default]
region = us-east-2 
output = json

credentials file sample

[default]
aws_access_key_id = AKIAS7AAAAAA
aws_secret_access_key = 9xoQVtg****************************


1) You should have k8s_rsa and k8s_ras.pub in your ~/.ssh directory
2) git pull the project 
3) terraform init
4) terraform apply -auto-approve
5) When done
   terraform destroy -auto-approve 
