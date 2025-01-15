package main

import (
	"fmt"
	"log"

	surrealdb "github.com/surrealdb/surrealdb.go"
	"github.com/surrealdb/surrealdb.go/pkg/models"
)

type Person struct {
	ID       *models.RecordID     `json:"id,omitempty"`
	Name     string               `json:"name"`
	Surname  string               `json:"surname"`
	Location models.GeometryPoint `json:"location"`
}

func main() {
	// データベース接続の設定
	db, err := surrealdb.New("ws://localhost:8000")
	if err != nil {
		log.Fatal(err)
	}

	// 認証情報の設定
	token, err := db.SignIn(&surrealdb.Auth{
		Username: "root",
		Password: "root",
	})
	if err != nil {
		log.Fatal(err)
	}

	// トークンの認証
	if err := db.Authenticate(token); err != nil {
		log.Fatal(err)
	}

	// セッション終了時にトークンを無効化
	defer func(token string) {
		if err := db.Invalidate(); err != nil {
			log.Fatal(err)
		}
	}(token)

	// データベースとネームスペースの使用
	if err = db.Use("test", "test"); err != nil {
		log.Fatal(err)
	}

	// Personの作成（マップを使用）
	person1, err := surrealdb.Create[Person](db, models.Table("persons"), map[interface{}]interface{}{
		"Name":     "山田",
		"Surname":  "太郎",
		"Location": models.NewGeometryPoint(139.7673068, 35.6809591), // 東京駅の座標
	})
	if err != nil {
		log.Fatal(err)
	}
	fmt.Printf("マップで作成したPerson: %+v\n", person1)

	// Personの作成（構造体を使用）
	person2, err := surrealdb.Create[Person](db, models.Table("persons"), Person{
		Name:     "鈴木",
		Surname:  "花子",
		Location: models.NewGeometryPoint(135.4983028, 34.7024854), // 大阪駅の座標
	})
	if err != nil {
		log.Fatal(err)
	}
	fmt.Printf("構造体で作成したPerson: %+v\n", person2)

	// 全てのPersonを取得
	persons, err := surrealdb.Select[[]Person](db, models.Table("persons"))
	if err != nil {
		log.Fatal(err)
	}
	fmt.Printf("全てのPerson: %+v\n", persons)

	// IDによる特定のPersonの取得
	person, err := surrealdb.Select[Person](db, *person1.ID)
	if err != nil {
		log.Fatal(err)
	}
	fmt.Printf("IDで取得したPerson: %+v\n", person)
}
