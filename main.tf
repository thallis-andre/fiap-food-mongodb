provider "mongodbatlas" {
  public_key  = var.atlas_public_key
  private_key = var.atlas_private_key
}

# Create Project
resource "mongodbatlas_project" "fiap_food" {
  org_id = var.atlas_org_id
  name   = var.atlas_project_name
}

resource "mongodbatlas_cluster" "fiap_food" {
  project_id                  = mongodbatlas_project.fiap_food.id
  name                        = var.atlas_cluster_name
  cluster_type                = "REPLICASET"
  provider_instance_size_name = "M0"
  provider_name               = "TENANT"
  backing_provider_name       = "AWS"
  provider_region_name        = "US_EAST_1"
  disk_size_gb                = 0.5
}

resource "mongodbatlas_project_ip_access_list" "allow_all_access" {
  project_id = mongodbatlas_project.fiap_food.id
  cidr_block = "0.0.0.0/0"
  comment    = "Allow All Access"
}

resource "random_password" "db_pass_payments" {
  length           = 16
  special          = true
  override_special = "_%@"
}

resource "mongodbatlas_database_user" "db_user_payments" {
  username           = "payments-app"
  password           = random_password.db_pass_payments.result
  project_id         = mongodbatlas_project.fiap_food.id
  auth_database_name = "admin"
  roles {
    role_name     = "readWrite"
    database_name = "Payments"
  }
}

resource "random_password" "db_pass_orders" {
  length           = 16
  special          = true
  override_special = "_%@"
}

resource "mongodbatlas_database_user" "db_user_orders" {
  username           = "orders-app"
  password           = random_password.db_pass_orders.result
  project_id         = mongodbatlas_project.fiap_food.id
  auth_database_name = "admin"
  roles {
    role_name     = "readWrite"
    database_name = "Orders"
  }
}

resource "random_password" "db_pass_gm50x" {
  length           = 16
  special          = true
  override_special = "_%@"
}

resource "mongodbatlas_database_user" "db_user_gm50x" {
  username           = "gm50x-admin"
  password           = random_password.db_pass_gm50x.result
  project_id         = mongodbatlas_project.fiap_food.id
  auth_database_name = "admin"

  roles {
    role_name     = "readWriteAnyDatabase"
    database_name = "admin"
  }
}
