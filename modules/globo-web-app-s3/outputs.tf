# bucket_object
output "web_bucket" {
  value = aws_s3_bucket.web_bucket
}

# instance_profile_object
output "instance_profile" {
  value = aws_iam_instance_profile.nginx_profile
}