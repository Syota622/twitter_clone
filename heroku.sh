# heroku
・Herokuにログイン
heroku login

・Herokuのスタックをheroku-20に設定する（ruby:3.0.2の場合はこれ必要）
heroku stack:set heroku-20

・ローカルのmainブランチをHerokuのfeature/product-list-\&-product-detailsブランチにプッシュする
git push heroku feature/product-list-\&-product-details:main
git push heroku feature/product-management:main

・Heroku上でデータベースマイグレーションを実行する
heroku run rake db:migrate

・Heroku上でデータベースシードを実行する
heroku run rake db:seed

・Herokuのwebプロセスを1つにスケールする
heroku ps:scale web=1

・Heroku上のプロセスの状態を確認する
heroku ps

・Herokuアプリを開く
heroku open

・Herokuのログを表示する
heroku logs

・データベースをリセット
git push heroku develop:main
・・データベースをマイグレーション
heroku run rake db:migrate:reset
・・初期データを投入
heroku run rake db:seed

・Rails コンソール
heroku run rails console

・Heroku 再起動
heroku restart

・Heroku プロセスの停止
$ heroku ps:scale web=0
# 再びスタートするときは↓
$ heroku ps:scale web=1

・Herokuのソースコードを確認
heroku git:clone -a lit-savannah-08687

・画像やPDFをアップロードするための設定
heroku buildpacks:add -i 1 https://github.com/heroku/heroku-buildpack-activestorage-preview

・データを再登録
heroku config:set RAILS_MASTER_KEY=5a27f51780fc982ce098b8b536cb1b22
heroku pg:reset DATABASE --confirm lit-savannah-08687
heroku run rails db:migrate
heroku run rake db:seed

・Herokuのデータベースに接続する方法
heroku pg:psql -a lit-savannah-08687
