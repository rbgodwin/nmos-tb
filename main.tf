terraform {
    required_version = ">= 0.12"
    backend "s3" {
        bucket = "myapp-bucket-nt"
        region = "eu-west-1"
        key = "myapp/state.tfstate"
    }
}


provider "aws" {
    region = "eu-west-1"
}



resource "aws_vpc" "myapp-vpc" {
    cidr_block = var.vpc_cidr_block
    tags = {
        Name = "${var.env_prefix}-vpc"
    }
}

# Set up the VPC Network
module "myapp-subnet" {
    source = "./modules/subnet"
    subnet_cidr_block = var.subnet_cidr_block
    avail_zone = var.avail_zone 
    env_prefix = var.env_prefix
    vpc_id = aws_vpc.myapp-vpc.id
    default_route_table_id = aws_vpc.myapp-vpc.default_route_table_id
}

# Set up the Application Server
module "myapp-server" {
    source = "./modules/webserver"
    vpc_id = aws_vpc.myapp-vpc.id
    my_ip = var.my_ip
    env_prefix = var.env_prefix
    image_name = var.image_name
    public_key_location = var.public_key_location
    private_key_location = var.private_key_location
    instance_type = var.instance_type
    subnet_id = module.myapp-subnet.subnet.id
    avail_zone = var.avail_zone
    private_dns_server = var.private_dns_server
}


### Setup DNS to use our BIND 9 DNS (Note this is AWS Specific)

# Create the resolver
resource "aws_vpc_dhcp_options" "dns_resolver" {

    domain_name_servers = [
#        module.myapp-server.private_ip
         "8.8.8.8"
 
    ]
    tags = {
        Name = "DNS_Resolver"
    }
}

# Assosiate it with our VPC

resource "aws_vpc_dhcp_options_association" "dns_resolver" {

    vpc_id = aws_vpc.myapp-vpc.id
    dhcp_options_id = aws_vpc_dhcp_options.dns_resolver.id

}