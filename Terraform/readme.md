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

### iam_users.tf
**Resources**
- **variables**: keybase as well as username variables are defined in an array list.  These will be used in the resource declarations later.
- **aws_iam_group**: Creates the group "thegroup" and an arganizational path of /cit480/.
- **aws_iam_user**: Creates the users from a loop inside with the variable array "username".
- **aws_iam_user_group_membership**:  Adds the users to the group "thegroup".
- **aws_iam_group_policy**: Creates a group policy for the group and adds it to the group.
- **aws_iam_user_login_profile**: Creates a login profile using the users created and the keybase accounts passed into it.
- **output**: Outputs the encrypted passwords to the command prompt to be sent to each user.
