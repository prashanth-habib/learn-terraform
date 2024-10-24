##################################################################################
# DATA
##################################################################################

data "aws_ssm_parameter" "amzn2_linux" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

##################################################################################
# INSTANCES
##################################################################################

resource "aws_instance" "nginx" {
  count                  = var.instance_count
  ami                    = nonsensitive(data.aws_ssm_parameter.amzn2_linux.value)
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.public_subnet[(count.index % var.vpc_publicsubnet_count)].id
  vpc_security_group_ids = [aws_security_group.nginx_sg.id]
  iam_instance_profile   = aws_iam_instance_profile.nginx_profile.name
  depends_on             = [aws_iam_role_policy.allow_s3_all]

  user_data = templatefile("${path.module}/templates/startup_script.tpl", {
    s3_bucket_name = aws_s3_bucket.web_bucket.id
  })

  tags = merge(local.common_tags, {
    Name = "${local.naming_prefix}-nginx-${count.index}"
  })
}

# aws_iam_role
resource "aws_iam_role" "allow_nginx_s3" {
  name = "allow_nginx_s3"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  tags = merge(local.common_tags, {
    Name = "${local.naming_prefix}-nginx"
  })
}

# aws_iam_instance_profile
resource "aws_iam_instance_profile" "nginx_profile" {
  name = "${local.naming_prefix}-nginx_profile"
  role = aws_iam_role.allow_nginx_s3.name

  tags = local.common_tags
}

# aws_iam_role_policy
resource "aws_iam_role_policy" "allow_s3_all" {
  name = "${local.naming_prefix}-allow_s3_all"
  role = aws_iam_role.allow_nginx_s3.name

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:*"
      ],
      "Effect": "Allow",
      "Resource": [
                "arn:aws:s3:::${local.s3_bucket_name}",
                "arn:aws:s3:::${local.s3_bucket_name}/*"
            ]
    }
  ]
}
EOF

}