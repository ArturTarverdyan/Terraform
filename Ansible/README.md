# Ansible #

- Ansible task one is to install apache and copy over the webserver html, css, and js files to those EC2 instances.

- This must be done through the bastion set up to transfer it to the webservers as the middle-man.

- Ansible task two is to install fail2ban on the bastion in order to make it more secure.

## Website ##

### Instructions ###

**1)** Take the generated {{user}}.pem file and move it to ~/.ssh/{{user}}.pem

**2)** Enter the hosts file, and replace {{webserver1 ip}} & {{webserver2 ip}} & {{bastion ip}} with the correct IP addresses.

**3)** Enter the hosts file, and replace {{user}}.pem with correct .pem file.

