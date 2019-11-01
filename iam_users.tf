provider "aws" {
  region		  = "us-west-2"
}

variable "username" {
  type    = "list"
  default = ["mark", "artur", "luis", "garrett"]
}

resource "aws_iam_group" "thegroup" {
  name   = "thegroup"
  path   = "/cit480/"
}

resource "aws_iam_user" "user_creation" {
  count  = "${length(var.username)}"
  name   = "${element(var.username, count.index)}"
  path   = "/cit480/"
}

resource "aws_iam_user_group_membership" "add" {
  count = "${length(var.username)}"
  user = "${element(var.username, count.index)}"

  groups = [
    "${aws_iam_group.thegroup.name}",
  ]
}

resource "aws_iam_group_policy" "cit480policy" {
  name = "cit480policy"
  group = "${aws_iam_group.thegroup.id}"
  
  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Stmt1572583073912",
      "Action": "*",
      "Effect": "Allow",
      "Resource": "*",
      "Condition": {
        "StringEquals": {
          "aws:RequestedRegion": "us-west-2"
        }
      }
    }
  ]
}
POLICY
}
