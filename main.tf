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



resource "aws_vpc" "nmos-tb-vpc" {
    cidr_block = var.vpc_cidr_block
    tags = {
        Name = "${var.env_prefix}-nmos-tb-vpc"
    }

}

# Set up the VPC Network
module "nmos-tb-subnet" {
    source = "./modules/subnet"
    subnet_cidr_block = var.subnet_cidr_block
    avail_zone = var.avail_zone 
    env_prefix = var.env_prefix
    vpc_id = aws_vpc.nmos-tb-vpc.id
    default_route_table_id = aws_vpc.nmos-tb-vpc.default_route_table_id
}

# Set up the DNS Server
module "dns-server" {
    source = "./modules/dns-server"
    vpc_id = aws_vpc.nmos-tb-vpc.id
    my_ip = var.my_ip
    env_prefix = var.env_prefix
    image_name = var.image_name
    public_key_location = var.public_key_location
    private_key_location = var.private_key_location
    instance_type = var.instance_type
    subnet_id = module.nmos-tb-subnet.subnet.id
    avail_zone = var.avail_zone
}


# Set up the RDS Server
module "rds-server" {
    source = "./modules/rds-server"
    vpc_id = aws_vpc.nmos-tb-vpc.id
    my_ip = var.my_ip
    env_prefix = var.env_prefix
    image_name = var.image_name
    public_key_location = var.public_key_location
    private_key_location = var.private_key_location
    instance_type = var.instance_type
    subnet_id = module.nmos-tb-subnet.subnet.id
    avail_zone = var.avail_zone
}



### Setup DNS to use our BIND 9 DNS

# Create the resolver
resource "aws_vpc_dhcp_options" "dns_resolver" {

    domain_name_servers = [
        "${module.dns-server.instance.private_ip}",
        "8.8.8.8"
 
    ]
    domain_name = "nmos.domain"
    tags = {
        Name = "NMOS Testbed DNS_Resolver"
    }
}

# Associate it with our VPC

resource "aws_vpc_dhcp_options_association" "dns_resolver" {

    vpc_id = aws_vpc.nmos-tb-vpc.id
    dhcp_options_id = aws_vpc_dhcp_options.dns_resolver.id

    depends_on = [aws_vpc_dhcp_options.dns_resolver, aws_vpc.nmos-tb-vpc]

}