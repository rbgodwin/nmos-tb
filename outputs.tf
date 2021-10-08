output "ec2_public_ip" {
    value = module.dns-server.instance.public_ip
}

output "ec2_private_ip" {
    value = module.dns-server.instance.private_ip
}