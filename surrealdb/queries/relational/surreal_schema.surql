-- リレーショナルデータモデル用のスキーマ定義
DEFINE TABLE user SCHEMAFULL;
DEFINE FIELD name ON user TYPE string;
DEFINE FIELD email ON user TYPE string ASSERT string::is::email($value);
DEFINE FIELD created_at ON user TYPE datetime DEFAULT time::now();

DEFINE TABLE post SCHEMAFULL;
DEFINE FIELD title ON post TYPE string;
DEFINE FIELD content ON post TYPE string;
DEFINE FIELD author ON post TYPE record<user>;
DEFINE FIELD created_at ON post TYPE datetime DEFAULT time::now();

DEFINE TABLE comment SCHEMAFULL;
DEFINE FIELD content ON comment TYPE string;
DEFINE FIELD author ON post TYPE record<user>;
DEFINE FIELD post ON comment TYPE record<post>;
DEFINE FIELD created_at ON comment TYPE datetime DEFAULT time::now();

-- リレーションの定義
DEFINE TABLE user_follows SCHEMAFULL;
DEFINE FIELD follower ON user_follows TYPE record<user>;
DEFINE FIELD following ON user_follows TYPE record<user>;
DEFINE FIELD created_at ON user_follows TYPE datetime DEFAULT time::now(); 