output "mongodb_connection_string" {
  value     = mongodbatlas_cluster.fiap_food.connection_strings[0].standard_srv
  sensitive = true
}

output "mongodb_username_payments" {
  value     = mongodbatlas_database_user.db_user_payments.username
  sensitive = true
}

output "mongodb_password_payments" {
  value     = mongodbatlas_database_user.db_user_payments.password
  sensitive = true
}

output "mongodb_username_orders" {
  value     = mongodbatlas_database_user.db_user_orders.username
  sensitive = true
}

output "mongodb_password_orders" {
  value     = mongodbatlas_database_user.db_user_orders.password
  sensitive = true
}

output "mongodb_username_gm50x" {
  value     = mongodbatlas_database_user.db_user_gm50x.username
  sensitive = true
}

output "mongodb_password_gm50x" {
  value     = mongodbatlas_database_user.db_user_gm50x.password
  sensitive = true
}
