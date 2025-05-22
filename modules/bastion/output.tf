output "bastion_host_public_ip" {
  value = aws_instance.bastion_host.public_ip
}

output "bastion_security_group_id" {
  value = aws_security_group.bastion_security_group.id
}