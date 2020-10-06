output "rds_endpoint" {
    value = "${aws_rds_cluster.rds_cluster_endpoint}"
}

output "rds_reader_endpoint" {
  value = "${aws_rds_cluster.rds_cluster.reader_endpoint}"
}

output "rds_cluster_id" {
  value = "${aws_rds_cluster.rds_cluster.id}"
}

output "rds_master_password" {
  value = "${random_string.rds_master_password.result}"
}

output "rds_db_name" {
  value = "${aws_rds_cluster.rds_cluster.database_name}"
}

output "rds_db_username" {
  value = "${aws_rds_cluster.rds_cluster.master_username}"
}