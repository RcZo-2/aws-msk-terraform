output "bastion_sg_id" {
  description = "The ID of the bastion's security group"
  value       = aws_security_group.bastion_sg.id
}
