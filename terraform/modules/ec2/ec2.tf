variable "stack_name" {}
variable "public_subnet_id" {}
variable "vpc_id" {}
variable "s3_bucket_arn" {}

data "aws_region" "current" {}

data "aws_ami" "laravel-ami" {
  most_recent = true
  source = "./ami/ami.tf"
  filter {
    name   = "name"
    values = ["laravel-ami"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["536510685689"]
}

resource "aws_instance" "laravel-vm" {
  ami                         = "${data.aws_ami.laravel-ami.id}"
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  key_name                    = "${aws_key_pair.generated.key_name}"
  vpc_security_group_ids      = ["${aws_security_group.ec2_security_group.id}"]
  subnet_id                   = "${var.public_subnet_id}"
  iam_instance_profile        = "${aws_iam_instance_profile.vm_profile.name}"

  tags {
    Name = "${var.stack_name}"
  }
}

resource "aws_security_group" "ec2_security_group" {
  name   = "${var.stack_name}-ec2"
  vpc_id = "${var.vpc_id}"

  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol    = "tcp"
    from_port   = 2376
    to_port     = 2376
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "${var.stack_name}"
  }
}

resource "aws_iam_role" "role" {
  name = "ec2_role_${var.stack_name}_${terraform.workspace}"
  path = "/"

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
}

resource "aws_iam_role_policy" "ec2_role_policy" {
  name = "ec2-policy-${var.stack_name}"
  role = "${aws_iam_role.role.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
      {
         "Effect": "Allow",
         "Action": [
            "logs:*"
         ],
         "Resource": [
            "*"
         ]
      },
      {
         "Effect": "Allow",
         "Action": [
            "s3:*"
         ],
         "Resource": [
            "${var.s3_bucket_arn}"
         ]
      }
  ]
}
EOF
} 
