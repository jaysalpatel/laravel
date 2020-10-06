variable "stack_name" {}

variable "subnet_ids" {
  type = "list"
}

variable "vpc_id" {}

data "aws_region" "current" {}
data "aws_availability_zones" "available" {}

data "aws_vpc" "vpc" {
  id = "${var.vpc_id}"
}

locals {
  nb_azs = "${length(data.aws_availability_zones.available.names)}"
}

resource "random_string" "rds_master_password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "random_string" "final_snapshot_id" {
  length  = 24
  special = false
}

resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "rds_db_subnet_group_${var.stack_name}_${terraform.workspace}"
  subnet_ids = ["${var.subnet_ids}"]

  tags {
    Name = "${var.stack_name}"
  }
}

resource "aws_security_group" "db_security_group" {
  vpc_id = "${data.aws_vpc.vpc.id}"

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "TCP"
    cidr_blocks = ["${data.aws_vpc.vpc.cidr_block}"]
  }

  tags {
    Name = "${var.stack_name}"
  }
}

resource "aws_rds_cluster" "rds_cluster" {
  engine                       = "rds-mysql"
  engine_version               = "5.7.12"
  database_name                = "${var.stack_name}_db"
  master_username              = "admin"
  master_password              = "password"
  backup_retention_period      = 14
  preferred_backup_window      = "12:00-1:00"
  preferred_maintenance_window = "mon:01:00-mon:02:00"
  db_subnet_group_name         = "${aws_db_subnet_group.rds_subnet_group.name}"
  final_snapshot_identifier    = "l${random_string.final_snapshot_id.result}l"

  vpc_security_group_ids = [
    "${aws_security_group.db_security_group.id}",
  ]

  tags {
    Name = "${var.stack_name}"
  }
}

resource "aws_rds_cluster_instance" "rds_cluster_instance" {
  count                = 1
  cluster_identifier   = "${aws_rds_cluster.rds_cluster.id}"
  instance_class       = "db.t2.micro"
  db_subnet_group_name = "${aws_db_subnet_group.rds_subnet_group.name}"
  publicly_accessible  = false
  engine               = "rds-mysql"
  engine_version       = "5.7.12"

  tags {
    Name = "${var.stack_name}"
  }
}