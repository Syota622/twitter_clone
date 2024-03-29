# heroku
## Herokuにログイン
heroku login

## Herokuのスタックをheroku-22に設定する（ruby:3.2.1）
heroku create --stack heroku-22

## 作成したスタックを確認する
heroku stack

## ローカルのfeature/singup-and-loginブランチをHerokuのmainブランチにプッシュする
git push heroku feature/singup-and-login:main
git push heroku feature/github-login:main
git push heroku feature/top_page:main

## Heroku上でデータベースマイグレーションを実行する
heroku run rake db:migrate

## データの登録
heroku run rake db:seed

## Herokuのwebプロセスを1つにスケールする
heroku ps:scale web=1

## Heroku上のプロセスの状態を確認する
heroku ps

## Herokuアプリを開く
heroku open

## Herokuのログを表示する
heroku logs

## Herokuのアプリケーションにログインする
heroku run bash

## Rails コンソール
heroku run rails console

## Heroku 再起動
heroku restart

## Heroku プロセスの停止
$ heroku ps:scale web=0
# 再びスタートするときは↓
$ heroku ps:scale web=1

## Herokuのソースコードを確認
heroku git:clone -a powerful-mesa-07530

## Herokuのデータベースに接続する方法
heroku pg:psql -a powerful-mesa-07530

## Herokuに環境変数を設定する
heroku config:set RAILS_MASTER_KEY=〜〜〜
