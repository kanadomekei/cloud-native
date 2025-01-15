-- テーブルの定義
DEFINE TABLE persons SCHEMAFULL;

-- フィールドの定義
DEFINE FIELD name ON persons TYPE string;
DEFINE FIELD surname ON persons TYPE string;
DEFINE FIELD location ON persons TYPE geometry;

-- 必須フィールドの設定
DEFINE FIELD name ON persons ASSERT $value != NONE;
DEFINE FIELD surname ON persons ASSERT $value != NONE;
DEFINE FIELD location ON persons ASSERT $value != NONE; 