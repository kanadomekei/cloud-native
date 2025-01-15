-- スキーマの定義
DEFINE TABLE settings SCHEMAFULL;

-- 値は文字列型のみを許可
DEFINE FIELD value ON settings TYPE string;

-- アプリケーション設定
CREATE settings:theme SET 
    value = 'dark';

CREATE settings:language SET 
    value = 'ja';

CREATE settings:timezone SET 
    value = 'Asia/Tokyo';

-- ユーザー設定
CREATE settings:default_view SET 
    value = 'grid';

CREATE settings:notifications SET 
    value = 'enabled';

CREATE settings:font_size SET 
    value = 'medium';

-- システム設定
CREATE settings:maintenance_mode SET 
    value = 'off';

CREATE settings:cache_ttl SET 
    value = '3600';

CREATE settings:log_level SET 
    value = 'info';

CREATE settings:api_version SET 
    value = 'v1';

-- 全ての設定を取得
SELECT * FROM settings;

-- 特定のプレフィックスを持つ設定のみを取得
SELECT * FROM settings WHERE id CONTAINS 'system'; 