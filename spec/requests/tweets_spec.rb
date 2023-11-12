# spec/requests/tweets_spec.rb

require 'rails_helper'

RSpec.describe "Tweets", type: :request do
  before(:each) do
    # ユーザーをデータベースに作成
    @user = User.create!(
      email: 'test@example.com', 
      password: 'password123', 
      password_confirmation: 'password123',
      phone_number: '1234567890',
      birthdate: '2000-01-01'
    )
    sign_in @user
  end

  describe "POST /tweets" do
    # 正常系テスト；有効な属性値の場合
    context "with invalid attributes" do
      it "does not create a tweet and redirects to an error page" do
        post tweets_path, params: { tweet: { content: "" } } # 空のツイート内容
        expect(response).to have_http_status(:redirect) # リダイレクトを検証
        follow_redirect!
        expect(response).to have_http_status(:success) # リダイレクト先のページが成功ステータスであることを検証
      end
    end

    # 異常系テスト；無効な属性値の場合
    context "with invalid attributes" do
      it "does not create a tweet with content that is too long and redirects" do
        long_content = "a" * 141 # 141文字の長い内容
        post tweets_path, params: { tweet: { content: long_content } }
        expect(response).to have_http_status(:redirect) # リダイレクトを検証
        follow_redirect!
        expect(response).to have_http_status(:success) # リダイレクト先のページが成功ステータスであることを検証
      end
    end

  end
end
