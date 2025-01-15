-- IF文を使用した関数
DEFINE FUNCTION fn::get_discount($amount: number) {
    IF $amount >= 10000 {
        RETURN $amount * 0.2;
    } ELSE IF $amount >= 5000 {
        RETURN $amount * 0.1;
    } ELSE {
        RETURN 0;
    };
}; 

-- 関数の使用例
-- 12000円の場合（20%割引）
RETURN fn::get_discount(12000);

-- 7000円の場合（10%割引）
RETURN fn::get_discount(7000);

-- 3000円の場合（割引なし）
RETURN fn::get_discount(3000);
