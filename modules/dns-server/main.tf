

#  Security Group 
resource "aws_security_group" "dns-server-sg" {
    vpc_id = var.vpc_id
    name = "DNS Security Group"
    description = "Allows only ssh assess on port 22 and DNS port 53."

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
   #        cidr_blocks = [var.my_ip]
         cidr_blocks = ["0.0.0.0/0"]
    }
   ingress {
        from_port = 51280
        to_port = 51280
        protocol = "tcp"
#        cidr_blocks = [var.my_ip]
         cidr_blocks = ["0.0.0.0/0"]

    }

    ingress {
        from_port = 53
        to_port = 53
        protocol = "udp"
        cidr_blocks = ["0.0.0.0/0"]
    }

# Lookup from same host as DNS Server
    ingress {
        from_port = 953
        to_port = 953
        protocol = "tcp"
        cidr_blocks = ["127.0.0.1/32"]
    }

    ingress {
        from_port = 53
        to_port = 53
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        cidr_blocks       = ["0.0.0.0/0"]
        from_port         = 8
        to_port           = 0
        protocol          = "icmp"
        description       = "Allow ICMP"
    }

#TODO: Remove this once wireguard running
    ingress {
        cidr_blocks       = ["0.0.0.0/0"]
        from_port         = 0
        to_port           = 0
        protocol          = -1
        description       = "Allow All"
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        prefix_list_ids = []
    }


    tags = {
        Name = "${var.env_prefix}-dns-server-sg"
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
    key_name = "server-key-dns-server"
    public_key = file(var.public_key_location)
}

resource "aws_instance" "dns-server" {
     ami = data.aws_ami.latest-amazon-linux-image.id
     instance_type = var.instance_type

     subnet_id = var.subnet_id

    # Set Private IP
    private_ip = var.dns_address
    
     vpc_security_group_ids = [aws_security_group.dns-server-sg.id]
     availability_zone = var.avail_zone
     
     associate_public_ip_address = true
     key_name =  aws_key_pair.ssh-key.key_name

    connection {
        type ="ssh"
        host = self.public_ip
        user = "ec2-user"
        private_key = file(var.private_key_location)
    }

    #This instance does NAT so turn off the AWS check of source and destination
    source_dest_check = false

    provisioner "file" {
        source = "${path.module}/entry-script-dns.sh"
        destination = "/home/ec2-user/entry-script-dns.sh"
    }

    provisioner "file" {
        source = "${path.module}/conf/named.conf"
        destination = "/home/ec2-user/named.conf"
    }

    provisioner "file" {
        source = "${path.module}/conf/db.nmos-tb.org"
        destination = "/home/ec2-user/db.nmos-tb.org"
    }

  provisioner "file" {
        source = "${path.module}/conf/publickey"
        destination = "/home/ec2-user/publickey"
    }

 provisioner "file" {
        source = "${path.module}/conf/privatekey"
        destination = "/home/ec2-user/privatekey"
    }

 provisioner "file" {
        source = "${path.module}/conf/wg0.conf"
        destination = "/home/ec2-user/wg0.conf"
    }


    provisioner "remote-exec" {
        inline = [
            "chmod +x /home/ec2-user/entry-script-dns.sh",
            "/home/ec2-user/entry-script-dns.sh"
        ]
    }

     tags = {
        Name = "${var.env_prefix}-dns-server"
    }     

 }

 #Associate the Elastic IP with the DNS Server instance
    resource "aws_eip_association" "eip_assoc" {
        instance_id   = aws_instance.dns-server.id
        allocation_id = var.eip_id
    }