resource "yandex_mdb_mysql_database" "db" {
  cluster_id = var.cluster_id
  name       = var.db_name
}

resource "yandex_mdb_mysql_user" "user" {
  cluster_id = var.cluster_id
  name       = var.user_name
  password   = var.user_password
  
  depends_on = [yandex_mdb_mysql_database.db] 

  permission {
    database_name = var.db_name
    roles         = ["ALL"]
  }
}

output "db_name" { value = yandex_mdb_mysql_database.db.name }
