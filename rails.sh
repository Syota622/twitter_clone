# docker-compose 全て削除
docker-compose down --rmi all --volumes --remove-orphans

# setup
docker-compose build --no-cache & docker compose build
docker compose run --rm web bin/setup
docker compose run --rm web yarn install
docker compose up -d

### 💻 サインアップ、ログイン機能実装 ###

# Docker ビルド
docker-compose run --rm web bundle install
docker-compose build

# devise インストール
docker-compose run --rm web rails g devise:install

# User モデル作成
docker-compose run --rm web rails g devise User
docker-compose run --rm web rails db:migrate

# ユーザー専用のControllerとViewの生成
docker-compose run --rm web rails g devise:controllers users
docker-compose run --rm web rails g devise:views users

# Calling `DidYouMean::SPELL_CHECKERS.merge!(error_name => spell_checker)' has been deprecated. Please call `DidYouMean.correct_error(error_name, spell_checker)' instead
bundle update --bundler

# データベースコンテナのDBへ接続する
docker-compose exec db psql -U postgres -d myapp_development

# ロールバック
docker compose run --rm web rails db:rollback

# データベースのリセット
docker compose run --rm web rails db:drop db:create db:migrate
