# spec/requests/sessions_spec.rb

require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  # テストの実行前にユーザーを作成
  # before(:each)とは、各テストが実行される前に実行されるメソッド
  before(:each) do
    # ユーザー作成時にphone_numberとbirthdateも含める
    @user = User.create!(
      email: 'test@example.com', 
      password: 'password123', 
      password_confirmation: 'password123',
      phone_number: '1234567890',  # 適切な電話番号
      birthdate: '2000-01-01'      # 適切な生年月日
    )
  end

  describe "POST /users/sign_in" do
    # 正常系テスト: ユーザーが正しい情報でログイン
    context "with valid credentials" do
      it "logs in the user and redirects to the root page" do
        post user_session_path, params: {
          user: {
            email: @user.email,
            password: 'password123'  # 正しいパスワード
          }
        }
        # ログイン後にリダイレクトされることを確認
        expect(response).to have_http_status(:redirect)
        # リダイレクト先が正しいことを確認
        follow_redirect!
        # ログイン後のページに遷移することを確認
        expect(response).to have_http_status(:success)
      end
    end

    # 異常系テスト: ユーザーが無効な情報でログイン
    context "with invalid credentials" do
      it "does not log in the user and returns an error status" do
        post user_session_path, params: {
          user: {
            email: @user.email,
            password: 'wrongpassword'  # 間違ったパスワード
          }
        }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
