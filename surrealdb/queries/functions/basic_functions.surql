-- 基本的な文字列を返す関数
DEFINE FUNCTION fn::greeting($name: string) {
    RETURN "こんにちは、" + $name + "さん！";
};

-- 数値計算を行う関数
DEFINE FUNCTION fn::add_tax($price: number) {
    RETURN $price * 1.1;
};

-- 関数の実行
RETURN fn::greeting("田中");
RETURN fn::add_tax(1000); 