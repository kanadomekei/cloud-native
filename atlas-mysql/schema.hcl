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
}

table "posts" {
  schema = schema.atlas_db
  column "id" {
    null = false
    type = int
    auto_increment = true
  }
  column "title" {
    null = false
    type = varchar(255)
  }
  column "content" {
    null = false
    type = text
  }
  column "user_id" {
    null = false
    type = int
  }
  column "created_at" {
    null = false
    type = timestamp
    default = sql("CURRENT_TIMESTAMP")
  }
  column "updated_at" {
    null = false
    type = timestamp
    default = sql("CURRENT_TIMESTAMP")
  }
  
  primary_key {
    columns = [column.id]
  }
  foreign_key "post_author_fk" {
    columns     = [column.user_id]
    ref_columns = [table.users.column.id]
  }
  index "title_idx" {
    columns = [column.title]
  }
}

table "comments" {
  schema = schema.atlas_db
  column "id" {
    null = false
    type = int
    auto_increment = true
  }
  column "content" {
    null = false
    type = text
  }
  column "user_id" {
    null = false
    type = int
  }
  column "post_id" {
    null = false
    type = int
  }
  column "created_at" {
    null = false
    type = timestamp
    default = sql("CURRENT_TIMESTAMP")
  }

  primary_key {
    columns = [column.id]
  }
  foreign_key "comment_author_fk" {
    columns     = [column.user_id]
    ref_columns = [table.users.column.id]
  }
  foreign_key "comment_post_fk" {
    columns     = [column.post_id]
    ref_columns = [table.posts.column.id]
  }
}

schema "atlas_db" {
  charset = "utf8mb4"
  collate = "utf8mb4_0900_ai_ci"
}
