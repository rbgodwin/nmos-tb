output "dns-server-public_ip" {
    value = module.dns-server.instance.public_ip
}

output "dsn-server-private_ip" {
    value = module.dns-server.instance.private_ip
}


output "rds-server-public_ip" {
    value = module.rds-server.instance.public_ip
}

output "rds-server-private_ip" {
    value = module.rds-server.instance.private_ip
}