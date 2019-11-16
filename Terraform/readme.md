# Terraform Breakdown
Note: Each terraform script is executed at once as they are all in the same directory.

## File List:
- EC2.tf
- iam_users.tf
- main.tf
- route53.tf
- variables.tf
- vpc.tf

## File Breakdowns:
### EC2.tf:
**Resources**:
- **aws_instance**: Creation of the bastion and both webservers.
- **aws_security_group**: Creation of security groups for the bastion and both web servers.
- **aws_elb**: Creation of the elastic load balancer.
- **listener**: The ports the the elb listens on.
- **health_check**: Specifies the health specifications that need to be passed.
