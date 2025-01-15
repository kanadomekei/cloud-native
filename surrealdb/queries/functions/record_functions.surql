-- レコードを作成する関数
DEFINE FUNCTION fn::create_user($username: string, $age: number) {
    CREATE user SET 
        username = $username,
        age = $age,
        created_at = time::now()
    RETURN *;
};

-- レコードを検索する関数
DEFINE FUNCTION fn::find_adult_users() {
    RETURN (SELECT * FROM user WHERE age >= 20);
};