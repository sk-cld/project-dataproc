output "public_ip" {
  description = "Public IP of the server"
  value       = aws_instance.dataproc.public_ip
}

output "app_url" {
  description = "Where the app answers once the playbook has run"
  value       = "http://${aws_instance.dataproc.public_ip}:${var.app_port}/"
}

output "ssh_command" {
  description = "Log in to the server"
  value       = "ssh -i ${local.ssh_private_key} ${local.ssh_options} ubuntu@${aws_instance.dataproc.public_ip}"
}
