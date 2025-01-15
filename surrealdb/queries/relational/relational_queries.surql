-- ユーザーの作成
CREATE user:john SET 
    name = 'John Doe',
    email = 'john@example.com';

CREATE user:jane SET 
    name = 'Jane Smith',
    email = 'jane@example.com';

CREATE user:mike SET 
    name = 'Mike Johnson',
    email = 'mike@example.com';

CREATE user:sarah SET 
    name = 'Sarah Wilson',
    email = 'sarah@example.com';

-- 投稿の作成
CREATE post:1 SET 
    title = 'First Post',
    content = 'Hello SurrealDB!',
    author = user:john;

CREATE post:2 SET 
    title = 'Learning SurrealDB',
    content = 'This database is amazing!',
    author = user:jane;

CREATE post:3 SET 
    title = 'Web Development Tips',
    content = 'Here are some useful tips...',
    author = user:mike;

CREATE post:4 SET 
    title = 'Database Design',
    content = 'Best practices for database design...',
    author = user:john;

-- コメントの作成
CREATE comment:1 SET 
    content = 'Great post!',
    author = user:jane,
    post = post:1;

CREATE comment:2 SET 
    content = 'Thanks for sharing!',
    author = user:mike,
    post = post:1;

CREATE comment:3 SET 
    content = 'Very informative!',
    author = user:sarah,
    post = post:2;

CREATE comment:4 SET 
    content = 'I learned a lot from this.',
    author = user:john,
    post = post:3;

-- フォロー関係の作成
CREATE user_follows SET 
    follower = user:jane,
    following = user:john;

CREATE user_follows SET 
    follower = user:mike,
    following = user:john;

CREATE user_follows SET 
    follower = user:sarah,
    following = user:jane;

CREATE user_follows SET 
    follower = user:mike,
    following = user:jane;

-- クエリの例
-- 投稿とその著者、コメントを取得
SELECT * FROM post 
    FETCH author, comments;

-- ユーザーとそのフォロワーを取得
SELECT *,
    ->user_follows.follower AS followers
FROM user;

-- 特定のユーザーの投稿とコメントを取得
SELECT * FROM post 
WHERE author = user:john;

-- ユーザーごとのフォロワー数を取得
SELECT *,
    array::len(->user_follows.follower) AS follower_count
FROM user;

-- 投稿に対するコメント数でソート
SELECT *,
    array::len(<-comment.post) AS comment_count
FROM post
ORDER BY comment_count DESC; 