package main

import (
	"context"
	"database/sql"
	"fmt"
	"log"

	"go-sqlc/tutorial"

	_ "github.com/go-sql-driver/mysql"
)

func main() {
	// データベース接続
	db, err := sql.Open("mysql", "atlas_user:atlas_pass@tcp(localhost:3306)/atlas_db")
	if err != nil {
		log.Fatal(err)
	}
	defer db.Close()

	// Queriesインスタンスの作成
	queries := tutorial.New(db)
	ctx := context.Background()

	// 著者の作成
	result, err := queries.CreateAuthor(ctx, tutorial.CreateAuthorParams{
		Name: "山田太郎",
		Bio:  sql.NullString{String: "プログラマー", Valid: true},
		Age:  sql.NullInt32{Int32: 30, Valid: true},
	})
	if err != nil {
		log.Fatal(err)
	}

	// 作成されたIDを取得（必要な場合）
	id, err := result.LastInsertId()
	if err != nil {
		log.Fatal(err)
	}
	fmt.Printf("作成された著者のID: %d\n", id)

	// 作成された著者の取得
	createdAuthor, err := queries.GetCreatedAuthor(ctx)
	if err != nil {
		log.Fatal(err)
	}
	fmt.Printf("作成された著者: ID=%d, 名前=%s\n", createdAuthor.ID, createdAuthor.Name)

	// 全著者のリスト取得
	authors, err := queries.ListAuthors(ctx)
	if err != nil {
		log.Fatal(err)
	}
	fmt.Println("著者一覧:")
	for _, author := range authors {
		fmt.Printf("- ID=%d, 名前=%s\n", author.ID, author.Name)
	}

	// トランザクションの例
	tx, err := db.BeginTx(ctx, nil)
	if err != nil {
		log.Fatal(err)
	}

	// トランザクション用のQueriesインスタンス
	qtx := queries.WithTx(tx)

	// トランザクション内での操作
	_, err = qtx.CreateAuthor(ctx, tutorial.CreateAuthorParams{
		Name: "佐藤花子",
		Bio:  sql.NullString{String: "デザイナー", Valid: true},
		Age:  sql.NullInt32{Int32: 25, Valid: true},
	})

	if err != nil {
		tx.Rollback()
		log.Fatal(err)
	}

	if err := tx.Commit(); err != nil {
		log.Fatal(err)
	}
}
