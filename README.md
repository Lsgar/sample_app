# Ruby on Rails チュートリアル：サンプルアプリケーション

これは、以下のためのサンプルアプリケーションです。
[*Ruby on Rails Tutorial*](http://railstutorial.jp/)
by [Michael Hartl](http://www.michaelhartl.com/).


## 環境変数の設定

  サンプルデータ（sample_data.rake）を作成するために、以下の環境変数の設定が必要です。

    # configurations for spec
    TEST_USERNAME: foobar
    TEST_MAILADDRESS: foobar@example.jp

  reset password 機能を利用するために、以下の環境変数の設定が必要です。
  ※SMTPポートは587（固定）となっています。

    # configurations for Mailer
    DEFAULT_URL_OPTIONS: localhost
    SMTP_ADDRESS: smtp.gmail.com
    SMTP_DOMAIN: example.com
    SMTP_USERNAME: XXXXX@gmail.com
    SMTP_PASSWORD: XXXXXXXXXXXXXXXXXX  # 2段階認証を有効にして、アプリパスワードを新規作成して設定
