output "rds_cluster_id" {
  value = "${module.rds.rds_cluster_id}"
}

output "rds_endpoint" {
  value = "${module.aurora.rds_endpoint}"
}

output "rds_reader_endpoint" {
  value = "${module.rds.rds_reader_endpoint}"
}

output "rds_master_password" {
  value = "${module.rds.rds_master_password}"
  sensitive = true
}

output "rds_master_username" {
  value = "${module.rds.rds_db_username}"
}

output "rds_db_name" {
  value = "${module.rds.rds_db_name}"
}

output "vpc_id" {
  value = "${module.vpc.vpc_id}"
}

output "ec2_ip" {
  value = "${module.ec2.ec2_ip}"
}

output "ssh_key_path" {
  value = "${module.ec2.ssh_key_path}"
}

output "public_subnet_ids" {
  value = "${module.vpc.public_subnet_ids}"
}

output "private_subnet_ids" {
  value = "${module.vpc.private_subnet_ids}"
}

output "bucket" {
  value = "${module.s3.s3_bucket}"
}