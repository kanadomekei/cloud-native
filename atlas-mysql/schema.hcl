table "users" {
  schema = schema.atlas_db
  column "id" {
    null = false
    type = int
  }
  column "name" {
    null = true
    type = varchar(100)
  }
  column "author_id" {
    null = true
    type = int
  }
  primary_key {
    columns = [column.id]
  }
  foreign_key "author_fk" {
    columns     = [column.author_id]
    ref_columns = [table.users.column.id]
  }
}
schema "atlas_db" {
  charset = "utf8mb4"
  collate = "utf8mb4_0900_ai_ci"
}
