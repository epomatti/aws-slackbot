resource "aws_iam_instance_profile" "slackbot" {
  name = "slackbot-intance"
  role = aws_iam_role.slackbot.id
}

resource "aws_instance" "slackbot" {
  ami           = "ami-08fdd91d87f63bb09"
  instance_type = "t4g.nano"

  associate_public_ip_address = true
  subnet_id                   = var.subnet
  vpc_security_group_ids      = [aws_security_group.slackbot.id]

  availability_zone    = var.az
  iam_instance_profile = aws_iam_instance_profile.slackbot.id

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  monitoring    = false
  ebs_optimized = false

  root_block_device {
    encrypted = true
  }

  lifecycle {
    ignore_changes = [
      ami,
      associate_public_ip_address
    ]
  }

  tags = {
    Name = "slackbot-test"
  }
}

### IAM Role ###

resource "aws_iam_role" "slackbot" {
  name = "slackbot-ec2-test"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

data "aws_iam_policy" "AmazonSSMManagedInstanceCore" {
  arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role_policy_attachment" "ssm-managed-instance-core" {
  role       = aws_iam_role.slackbot.name
  policy_arn = data.aws_iam_policy.AmazonSSMManagedInstanceCore.arn
}

resource "aws_security_group" "slackbot" {
  name        = "ec2-ssm-slackbot-test"
  description = "Controls access for EC2 via Session Manager"
  vpc_id      = var.vpc_id

  tags = {
    Name = "sg-ssm-slackbot-test"
  }
}

resource "aws_security_group_rule" "all_egress" {
  description       = "Allow VPC all egress"
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = []
  security_group_id = aws_security_group.slackbot.id
}

