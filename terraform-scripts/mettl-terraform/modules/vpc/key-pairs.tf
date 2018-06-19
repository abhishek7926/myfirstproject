resource "aws_key_pair" "auth" {
  key_name   = "${format("%s", lower("${var.key_name}.${var.private_dns_zone_name}"))}"
  public_key = "${file(var.public_key_path)}"
}
