module "iam" {
  source    = "./modules/iam"
  role_name = "ecs-task-role"
}

module "networks" {
  source         = "./modules/network"
  vpc_cidr_block = ["10.0.0.0/16"]
  vpc_name       = "main_vpc"

  pub_subnet1_name       = "public_subnet1"
  pub_subnet1_cidr_block = ["10.0.1.0/24"]

  pub_subnet2_name       = "public_subnet2"
  pub_subnet2_cidr_block = ["10.0.2.0/24"]

  prvt_subnet_name       = "private_subnet"
  prvt_subnet_cidr_block = ["10.0.3.0/24"]
}


module "ecs" {
  source                = "./modules/ecs"
  role_arn              = module.iam.role_arn
  task_family           = "service"
  cluster_name          = "my-cluster"
  docker_container_name = "testaws"
  docker_image          = "steeve05/aws:latest"
  container_port        = 3000
}

module "ecsService" {
  source              = "./modules/ecsService"
  cluster_id          = module.ecs.cluster_id
  task_definition_arn = module.ecs.task_definition_arn
  task_def_dependency = module.ecs.task_def_dependency
  target_group_id     = module.load_balancer.target_group_id

  #----
  private_subnet_id = module.networks.prvt_subnet_id #!!! change to private (testing purpose for now)
  security_group_id = module.networks.sec_group_id
  ecs_service_name  = "my-ecs-service"
  container_name    = module.ecs.container_name
  container_port    = 3000
}



module "load_balancer" {
  source                = "./modules/alb"
  public_subnet1_id     = module.networks.public1_subnet_id
  public_subnet2_id     = module.networks.public2_subnet_id
  security_group_id     = module.networks.sec_group_id
  vpc_id                = module.networks.vpc_id
  alb_name              = "my-app-alb"
  ecs_target_group_name = "ecs-target-group"
}


#_-----------------------------------------------------------





# resource "aws_vpc" "main_vpc" {
#   cidr_block       = "10.0.0.0/16"
#   instance_tenancy = "default"

#   tags = {
#     Name = "main_vpc"
#   }
# }


# resource "aws_subnet" "public_subnet_1a" {
#   vpc_id                  = aws_vpc.main_vpc.id
#   cidr_block              = "10.0.1.0/24"
#   availability_zone       = "us-east-1a"
#   map_public_ip_on_launch = true
#   tags = {
#     Name = "public_subnet1"
#   }
# }

# resource "aws_subnet" "public_subnet_1b" {
#   vpc_id                  = aws_vpc.main_vpc.id
#   cidr_block              = "10.0.2.0/24"
#   availability_zone       = "us-east-1b"
#   map_public_ip_on_launch = true
#   tags = {
#     Name = "public_subnet2"
#   }
# }


# resource "aws_subnet" "private_subnet" {
#   vpc_id                  = aws_vpc.main_vpc.id
#   cidr_block              = "10.0.3.0/24"
#   availability_zone       = "us-east-1a"
#   map_public_ip_on_launch = true
#   tags = {
#     Name = "private_subnet"
#   }
# }


# resource "aws_internet_gateway" "igw" {
#   vpc_id = aws_vpc.main_vpc.id

#   tags = {
#     Name = "InternetGateWay"
#   }
# }


# resource "aws_eip" "nat_eip" {
#   #   vpc = true  # Ensure the EIP is for a VPC
# }


# resource "aws_nat_gateway" "nat" {
#   allocation_id = aws_eip.nat_eip.id
#   subnet_id     = aws_subnet.public_subnet_1a.id

#   tags = {
#     Name = "gwNAT"
#   }

#   # To ensure proper ordering, it is recommended to add an explicit dependency
#   # on the Internet Gateway for the VPC.
#   depends_on = [aws_internet_gateway.igw]
# }

#-----------------------------------------------------

# resource "aws_route_table" "public_route_table" {
#   vpc_id = aws_vpc.main_vpc.id # Reference to your VPC

#   tags = {
#     Name = "public-route-table"
#   }
# }

# resource "aws_route" "internet_route" {
#   route_table_id         = aws_route_table.public_route_table.id
#   destination_cidr_block = "0.0.0.0/0" # Route all traffic to the Internet
#   gateway_id             = aws_internet_gateway.igw.id
# }


# resource "aws_route_table_association" "public_route_table_association" {
#   subnet_id      = aws_subnet.public_subnet_1a.id        # Public subnet
#   route_table_id = aws_route_table.public_route_table.id # Route table to associate
# }

# resource "aws_route_table_association" "public_route_table_association" {
#   subnet_id      = aws_subnet.public_subnet_1b.id        # Public subnet
#   route_table_id = aws_route_table.public_route_table.id # Route table to associate
# }
# # #-----------------------------------------------------

# resource "aws_route_table" "private_route_table" {
#   vpc_id = aws_vpc.main_vpc.id  # Reference to your VPC

#   tags = {
#     Name = "private-route-table"
#   }
# }

# resource "aws_route" "private_route" {
#   route_table_id         = aws_route_table.private_route_table.id
#   destination_cidr_block = "0.0.0.0/0"  # Route all traffic to the Internet
#   nat_gateway_id             = aws_nat_gateway.nat.id
#   depends_on = [ aws_nat_gateway.nat ]
# }


# resource "aws_route_table_association" "private_route_table_association" {
#   subnet_id      = aws_subnet.private_subnet.id # Public subnet
#   route_table_id = aws_route_table.private_route_table.id  # Route table to associate
# }




# resource "aws_security_group" "sg" {
#   name        = "allow_https"
#   description = "Allow http access"
#   vpc_id      = aws_vpc.main_vpc.id

#   ingress {
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   ingress {
#     from_port   = 443
#     to_port     = 443
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   ingress {
#     from_port   = 3000
#     to_port     = 3000
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }
