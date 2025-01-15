-- 既存のテーブルを削除
REMOVE TABLE user;
REMOVE TABLE post;
REMOVE TABLE comment;
REMOVE TABLE user_follows;

-- ユーザーテーブルの作成
DEFINE TABLE user SCHEMAFULL;
DEFINE FIELD name ON user TYPE string;
DEFINE FIELD email ON user TYPE string ASSERT string::is::email($value);
DEFINE FIELD created_at ON user TYPE datetime DEFAULT time::now();

-- 投稿テーブルの作成
DEFINE TABLE post SCHEMAFULL;
DEFINE FIELD title ON post TYPE string;
DEFINE FIELD content ON post TYPE string;
DEFINE FIELD author ON post TYPE record<user>;
DEFINE FIELD created_at ON post TYPE datetime DEFAULT time::now();

-- コメントテーブルの作成
DEFINE TABLE comment SCHEMAFULL;
DEFINE FIELD content ON comment TYPE string;
DEFINE FIELD author ON comment TYPE record<user>; -- authorフィールドの修正
DEFINE FIELD post ON comment TYPE record<post>;
DEFINE FIELD created_at ON comment TYPE datetime DEFAULT time::now();

-- フォロー関係テーブルの作成
DEFINE TABLE user_follows SCHEMAFULL;
DEFINE FIELD follower ON user_follows TYPE record<user>;
DEFINE FIELD following ON user_follows TYPE record<user>;
DEFINE FIELD created_at ON user_follows TYPE datetime DEFAULT time::now();

-- インデックスの作成（オプション）
DEFINE INDEX user_email ON user FIELDS email UNIQUE;
DEFINE INDEX post_author ON post FIELDS author;
DEFINE INDEX comment_post ON comment FIELDS post;
DEFINE INDEX user_follows_composite ON user_follows FIELDS follower, following UNIQUE; 