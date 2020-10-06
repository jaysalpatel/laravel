Social Media App using Laravel as a framework. 
I have implemented a CICD pipeline in this project.


I used Github Actions as my continuous integration tool to monitor changes to the repo and
  checkout branch
  
  install all laravel framework dependencies
  
  execute all migration, to create database and all tables of database



Docker and Kubernetes are used to run the web and db applications
I have ArgoCD as a Continuous Delivery tool to sync changes from every commit to the repo to automatically apply YAML files and create new resources for the kubernetes cluster.

Terraform is an infrastructure as code tool to provision my AWS infrastructure with resources such as EC2 instances with composer and laravel installed on it, VPC with route tables and ingress, and an RDS cluster pointing to the appropriate subnets.

to initialize a working directory containing configuration files

  terraform init

To create an execution plan run

  terraform plan

to apply the changes to reach the desired state run

  terraform apply
  
  
Packer is used to create machine images with a provisioning script to install php packages, run php artisan commands and set file privilages to read, write and execute for owner
Also I will eventually implement a Continuous Integration step to build a packer AMI and push it to AWS and recreate EC2 instances with that specific AMI

this command will validate the tempalte
  packer validate
  
this command will build our template with the execution script to provision packages and dependencies
  packer build


I could have homestead instead to create custom vagrant boxes with php, composer, laravel and associated software packages installed
