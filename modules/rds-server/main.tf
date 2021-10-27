

#  Security Group 
resource "aws_security_group" "rds-server-sg" {
    name = "RDS Security Group"
    description = "Allows only ssh assess on port 22 and RDS port 8010."
    vpc_id = var.vpc_id

# SSH Access
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
#        cidr_blocks = [var.my_ip]
         cidr_blocks = ["0.0.0.0/0"]

    }

# NMOS RDS
     ingress {
        from_port = 8010
        to_port = 8011
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        prefix_list_ids = []
    }

    tags = {
        Name = "${var.env_prefix}-rds-server-sg"
    }
}

data "aws_ami" "latest-amazon-linux-image" {
    most_recent = true
    owners = ["amazon"]
    filter {
        name = "name"
        values = [var.image_name]
    }
    filter {
        name = "virtualization-type"
        values = ["hvm"]
    }
}


resource "aws_key_pair" "ssh-key"{
    key_name = "server-key-rds-server"
    public_key = file(var.public_key_location)
}

resource "aws_instance" "rds-server" {
     ami = data.aws_ami.latest-amazon-linux-image.id
     instance_type = var.instance_type

     subnet_id = var.subnet_id

     vpc_security_group_ids = [aws_security_group.rds-server-sg.id]
     availability_zone = var.avail_zone
     
     associate_public_ip_address = true
     key_name =  aws_key_pair.ssh-key.key_name

    # Set Private IP
    private_ip = var.rds_address

    connection {
        type ="ssh"
        host = self.public_ip
        user = "ec2-user"
        private_key = file(var.private_key_location)
    }

    provisioner "file" {
        source = "${path.module}/entry-script-rds.sh"
        destination = "/home/ec2-user/entry-script-rds.sh"
    }
 
    provisioner "file" {
        source = "${path.module}/conf/node.json"
        destination = "/tmp/node.json"
    }

    provisioner "file" {
        source = "${path.module}/conf/registry.json"
        destination = "/tmp/registry.json"
    }


    provisioner "remote-exec" {
        inline = [
            "chmod +x /home/ec2-user/entry-script-rds.sh",
            "/home/ec2-user/entry-script-rds.sh"
        ]
    }

     tags = {
        Name = "${var.env_prefix}-rds-server"
    }     

 }

