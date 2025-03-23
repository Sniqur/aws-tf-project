#   Fully automated deploy of Node.js app on AWS ECS

## Decription

This is my pet project I did to practice building the necessary infrastructure for a specific task on AWS Cloud. The task itself is to create an infrasturcture for deploying my simple containerized Node.js app and access it from the Public Internet. All the static files should be stored in Private S3 bucket and everything should be secured. The task was completed in compliance with all the best practices I knew at the moment.

Resources that I have deployed to accomplish the task by using Terraform: 

* Networks (VPC,Subnets, route tables, Internet GW, NAT GW, Elastic IP, Security Groups)
* IAM role
* Elastic Container Service (Cluster, Task Definition (FARGATE / LINUX x86_64), Service)
* ALB (Target Group, Listeners)

### To run this project You have to:

 * Clone the repo into your folder;
 
    `git clone https://github.com/Sniqur/aws-tf-project.git`

 * Get into cloned directory;

    `cd aws-tf-project` 

 * Get into terraform directory;

    `cd terraform`

* Init / Plan / Apply Terraform.

    `terraform init` - Initializes the Terraform working directory

    `terraform plan` - Creates an execution plan without making any changes

    `terraform apply` - Executes the actions proposed in the plan

#### P.S.
Change some values of variables in `main.tf` so You can deploy Your app. 
    