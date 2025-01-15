-- スキーマフルなグラフモデルの定義
DEFINE TABLE person SCHEMAFULL;
DEFINE FIELD name ON person TYPE string ASSERT $value != NONE;
DEFINE FIELD age ON person TYPE number ASSERT $value > 0;

-- エッジテーブルの厳密な定義
DEFINE TABLE knows SCHEMAFULL;
DEFINE FIELD strength ON knows TYPE number ASSERT $value >= 0 AND $value <= 1;
DEFINE FIELD since ON knows TYPE datetime DEFAULT time::now();
DEFINE FIELD relationship_type ON knows TYPE string 
    ASSERT $value INSIDE ['friend', 'family', 'colleague'];

-- エッジの方向性を制限
DEFINE TABLE knows SCHEMAFULL
    PERMISSIONS 
        FOR create, update 
        WHERE in != out; -- 自己参照を防ぐ 

-- サンプルデータの追加
-- 人物データの作成
CREATE person:p1 SET 
    name = "田中太郎",
    age = 35;

CREATE person:p2 SET 
    name = "山田花子",
    age = 28;

CREATE person:p3 SET 
    name = "佐藤健一",
    age = 42;

CREATE person:p4 SET 
    name = "鈴木美咲",
    age = 31;

-- 関係性の作成
CREATE knows SET 
    in = person:p1,
    out = person:p2,
    strength = 0.9,
    relationship_type = "friend";

CREATE knows SET 
    in = person:p2,
    out = person:p3,
    strength = 0.7,
    relationship_type = "colleague";

CREATE knows SET 
    in = person:p1,
    out = person:p3,
    strength = 1.0,
    relationship_type = "family";

CREATE knows SET 
    in = person:p4,
    out = person:p2,
    strength = 0.8,
    relationship_type = "friend";

-- サンプルクエリ例
-- 田中太郎の友人を取得
SELECT out.name, strength, relationship_type 
FROM knows 
WHERE in = person:p1;

-- 山田花子との関係がある人をすべて取得
SELECT in.name, out.name, relationship_type, strength 
FROM knows 
WHERE in = person:p2 OR out = person:p2;

-- family関係のみを取得
SELECT in.name, out.name, strength, since 
FROM knows 
WHERE relationship_type = "family"; 