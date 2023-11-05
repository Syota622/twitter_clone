# docker-compose 全て削除
docker-compose down --rmi all --volumes --remove-orphans

# setup
docker-compose build --no-cache & docker compose build
docker compose run --rm web bin/setup
docker compose run --rm web yarn install
docker compose up -d
docker compose run --rm web bundle exec rubocop -A

### 共通 ###

# Docker ビルド
docker-compose run --rm web bundle install
docker-compose build

# DB接続
docker-compose exec db psql -U postgres -d myapp_development

### 💻 サインアップ、ログイン機能実装 ###

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

# ロールバック
docker compose run --rm web rails db:rollback

# データベースのリセット
docker compose run --rm web rails db:drop db:create db:migrate

# サインイン後のリダイレクト先を変更
docker-compose run --rm web rails g controller home index

# gem "slim-rails" "html2slim" 
docker-compose run --rm web bundle install
docker-compose build
docker-compose run --rm web bundle exec erb2slim app/views/ --delete

### 💻 githubログインの実装 ###
docker-compose run --rm web rails generate migration AddOmniauthToUsers provider:string uid:string
docker-compose run --rm web rails db:migrate

### 💻 トップページの作成 ###
docker-compose run --rm web rails generate model Tweet content:text user:references
docker-compose run --rm web rails generate model FollowRelation follower_id:integer followee_id:integer

docker-compose run --rm web rails db:migrate
docker-compose run --rm web rails db:seed

docker-compose run --rm web rails generate controller Tweets

docker-compose run --rm web rails active_storage:install
docker-compose run --rm web rails db:migrate

# ページネーション install
docker-compose run --rm web bundle install
docker-compose build

docker-compose run --rm web rails generate kaminari:config
docker-compose run --rm web rails generate kaminari:views bootstrap4

### 💻 ユーザープロフィールページの作成
docker-compose run --rm web rails db:seed
docker-compose run --rm web rails generate migration AddProfileFieldsToUsers name:string avatar:string header_image:string bio:text location:string website:string
docker-compose run --rm web rails generate controller Profiles show
docker-compose run --rm web rails db:migrate
docker-compose run --rm web rails generate migration RemoveAvatarFromUsers avatar:string
docker-compose run --rm web rails db:migrate
docker-compose run --rm web rails generate migration RemoveHeaderImageFromUsers header_image:string
docker-compose run --rm web rails db:migrate
docker-compose run --rm web rails generate model Like user:references tweet:references
docker-compose run --rm web rails db:migrate
docker-compose run --rm web rails generate model Retweet user:references tweet:references
docker-compose run --rm web rails db:migrate
docker-compose run --rm web rails generate model Comment content:text user:references tweet:references
docker-compose run --rm web rails db:migrate

### 💻 ブックマーク
docker-compose run --rm web rails generate model Bookmark user:references tweet:references
docker-compose run --rm web rails db:migrate
docker-compose run --rm web rails generate controller Bookmarks

### 💻 メッセージ機能
docker-compose run --rm web rails generate controller Messages
docker-compose run --rm web rails generate model Message sender_id:integer recipient_id:integer content:text
docker-compose run --rm web rails db:migrate

### 💻 通知機能
docker-compose run --rm web rails generate controller Notifications
docker-compose run --rm web rails generate model Notification user:references actionable:references{polymorphic}
docker-compose run --rm web rails db:migrate
docker-compose run --rm web rails generate mailer NotificationMailer

### 自動テスト
