#!/bin/bash
sudo apt update && sudo apt upgrade -y
sudo apt install nginx -y 
sudo systemctl enable nginx
sudo systemctl start nginx
git clone https://github.com/mezaneus/terraform-devsecops-gcp-project1.git
cd /Mike-ezane
pip install requirements.txt
echo "*/10 * * * * $SHELL remediation.sh" | crontab -




 ## As you can see on my VS code, my startup script as soon as I provision terraform,
 ## and run terraform in it, terraform validate, terraform plan and terraform apply,
 ## it will provision the resources on these configuration files on the left;
 ## that is the compute resource, the IAM, the MFA, and networking resources. 
 ## After he does this, the Cron job on line 9 of my startup script, as you can see here,
 ## runs every 10 minutes and continuously monitors the environment. 
 ## If any anomalies are detected, it would auto-remediate.