package main

import (
	"fmt"
	"log"

	surrealdb "github.com/surrealdb/surrealdb.go"
)

func main() {
	// データベース接続の設定
	db, err := surrealdb.New("ws://localhost:8000")
	if err != nil {
		log.Fatal(err)
	}

	// 認証情報の設定
	_, err = db.SignIn(&surrealdb.Auth{
		Username: "root",
		Password: "root",
	})
	if err != nil {
		log.Fatal(err)
	}

	// データベースとネームスペースの使用
	if err = db.Use("test", "test"); err != nil {
		log.Fatal(err)
	}

	fmt.Println("SurrealDBに正常に接続されました！")
}
