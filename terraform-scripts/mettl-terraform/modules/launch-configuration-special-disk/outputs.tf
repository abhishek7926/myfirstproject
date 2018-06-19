output "name" {
  value = "${join(",", aws_launch_configuration.lc-special-disk.*.name)}"
}

