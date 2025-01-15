-- アプリケーション設定（シンプルな文字列値）
CREATE settings:theme SET 
    value = 'dark';

CREATE settings:language SET 
    value = 'ja';

-- 数値データ
CREATE settings:max_upload_size SET 
    value = 10485760,
    unit = 'bytes',
    readable = '10MB';

-- 配列データ
CREATE settings:allowed_file_types SET 
    value = ['jpg', 'png', 'pdf', 'doc'],
    max_size_per_type = {
        jpg: '5MB',
        png: '5MB',
        pdf: '10MB',
        doc: '8MB'
    };

-- オブジェクトデータ
CREATE settings:email_config SET 
    smtp = {
        host: 'smtp.example.com',
        port: 587,
        username: 'system@example.com',
        tls: true
    },
    templates = {
        welcome: 'templates/welcome.html',
        reset_password: 'templates/reset.html'
    },
    retry_policy = {
        max_attempts: 3,
        delay: 300
    };

-- ブール値とネストされた設定
CREATE settings:features SET 
    dark_mode = {
        enabled: true,
        auto_switch: true,
        schedule: {
            start: '18:00',
            end: '06:00'
        }
    },
    beta_features = {
        ai_assistant: false,
        voice_commands: true
    };

-- 配列内のオブジェクト
CREATE settings:notification_channels SET 
    channels = [
        {
            type: 'email',
            enabled: true,
            priority: 'high'
        },
        {
            type: 'slack',
            enabled: true,
            webhook_url: 'https://hooks.slack.com/xxx'
        },
        {
            type: 'line',
            enabled: false,
            token: 'line_token_xxx'
        }
    ];

-- クエリの例
-- 全ての設定を取得
SELECT * FROM settings;

-- 特定の設定の詳細を取得
SELECT ->notification_channels.channels 
FROM settings:notification_channels;

-- 有効なチャンネルのみを取得
SELECT channels[WHERE enabled = true].type 
FROM settings:notification_channels;

-- ネストされた設定値の取得
SELECT dark_mode.schedule 
FROM settings:features;