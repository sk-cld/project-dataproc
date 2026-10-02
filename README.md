# Data Processor deployment

Terraform creates an Ubuntu 22.04 server on AWS. Ansible configures it and runs a Python API behind
Nginx with Docker Compose, started by the `dataproc.service` systemd unit.

## Prerequisites

- Terraform 1.5+
- Ansible (ansible-core 2.15+), then `ansible-galaxy collection install -r ansible/requirements.yml`
- AWS credentials for an IAM user that can manage EC2
- An SSH key at `~/.ssh/id_ed25519` (or pass `-var="ssh_private_key_path=/path/to/key"` to Terraform)

## Run

```bash
# 1. Create the server (SSH and port 8080 open to your IP only)
cd terraform
terraform init
terraform apply -var="my_ip_cidr=$(curl -s https://checkip.amazonaws.com | tr -d '\n')/32"

# 2. Configure the server and deploy the app
cd ../ansible
ansible-playbook deploy.yml

# 3. Test
cd ../terraform
curl "$(terraform output -raw app_url)"

# 4. Clean up
terraform destroy -var="my_ip_cidr=$(curl -s https://checkip.amazonaws.com | tr -d '\n')/32"
```

The playbook finishes by checking that the site responds, the API container runs as UID 2048, and
Nginx is writing to `/var/log/nginx/custom-access.log`.

## Changes to the starter files

- `entrypoint.sh`: changed `#!/bin/sh` to `#!/bin/bash`, because the script uses a bash array.
- `app.py`: the port was read from `sys.argv[2]` (which is `"--port"`) and crashed; it now reads `--port` by name.
- UFW allows port 22 as well as 8080, so Ansible can connect over SSH.
