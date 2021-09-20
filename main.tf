provider "aws" {
  region = "eu-west-1"
}

variable "cidr_blocks" {
    description = "cidr blocks and nane tags for vpc and subnets"
    type = list(object({
        cidr_block = string
        name = string
    }))
}

resource "aws_vpc" "development-vpc" {
    cidr_block = var.cidr_blocks[0].cidr_block
    tags = {
        Name: var.cidr_blocks[0].name
    }
}

resource "aws_subnet"  "dev-subnet-1" {
    vpc_id = aws_vpc.development-vpc.id
    cidr_block = var.cidr_blocks[1].cidr_block
    availability_zone = "eu-west-1a"
    tags = {
        Name: var.cidr_blocks[1].name
    }
}

data "aws_vpc" "existing_vpc" {
    default = true
}

resource "aws_subnet"  "dev-subnet-2" {
    vpc_id = data.aws_vpc.existing_vpc.id
    cidr_block = "172.31.48.0/20"
    availability_zone = "eu-west-1a"
    tags = {
        Name: "subnet-2-dev"
    }
}


output "dev-vpc-id" {
    value = aws_vpc.development-vpc.id
}

output "dev-subnet-1-id" {
    value = aws_subnet.dev-subnet-1.id
}

output "dev-subnet-2-id" {
    value = aws_subnet.dev-subnet-1.id
}
