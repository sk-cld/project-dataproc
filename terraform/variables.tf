variable "my_ip_cidr" {
  description = "Your public IP as a /32 (e.g. 203.0.113.7/32). Only this address can reach SSH and the app."
  type        = string

  validation {
    condition     = can(cidrhost(var.my_ip_cidr, 0))
    error_message = "my_ip_cidr must be a CIDR block such as 203.0.113.7/32."
  }
}

variable "aws_region" {
  description = "AWS region to create the server in"
  type        = string
  default     = "us-east-1"
}

variable "aws_profile" {
  description = "AWS CLI profile to use. Leave unset to use the standard AWS credential chain (env vars, default profile, SSO)"
  type        = string
  default     = null
}

variable "ssh_private_key_path" {
  description = "Private SSH key for the server; the matching .pub file next to it is uploaded to AWS"
  type        = string
  default     = "~/.ssh/id_ed25519"
}

variable "ssh_known_hosts_file" {
  description = "known_hosts file that ssh and Ansible use for this server"
  type        = string
  default     = "~/.ssh/known_hosts"
}

variable "instance_type" {
  description = "EC2 instance size (x86_64)"
  type        = string
  default     = "t3.micro"
}

variable "app_port" {
  description = "App port opened in the security group (must match app_port in ansible/deploy.yml)"
  type        = number
  default     = 8080
}
