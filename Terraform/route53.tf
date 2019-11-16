resource "aws_route53_zone" "main" {
	name = "thegroupseniordesign.tech"
}

resource "aws_route53_record" "www" {
	zone_id = "${aws_route53_zone.main.zone_id}"
	name = "terraform-elb-960729877.us-west-2.elb.amazonaws.com"
	type = "A"
	ttl="300"
}

