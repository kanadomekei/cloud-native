-- ドキュメントデータモデル（スキーマレス）
DEFINE TABLE product SCHEMALESS;

-- 異なる構造を持つドキュメントの作成
CREATE product SET 
    name = 'Laptop',
    price = 999.99,
    specs = {
        cpu: 'Intel i7',
        ram: '16GB',
        storage: '512GB SSD'
    };

CREATE product SET 
    name = 'Desk',
    price = 299.99,
    dimensions = {
        width: 120,
        depth: 60,
        height: 75
    },
    material = 'Wood';

-- ネストされたドキュメントの検索
SELECT * FROM product 
WHERE specs.ram = '16GB'; 