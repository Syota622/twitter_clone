# spec/requests/registrations_spec.rb

require 'rails_helper'

RSpec.describe "Registrations", type: :request do
  describe "POST /users" do
    # 正常系
    context "when valid parameters" do
      it "creates a new user successfully" do
        post user_registration_path, params: {
          user: {
            email: 'test@example.com',
            password: 'password123',
            password_confirmation: 'password123',
            phone_number: '1234567890',
            birthdate: '2000-01-01'
          }
        }
        # リダイレクトがあることを確認
        expect(response).to have_http_status(:redirect)
        # オプション：リダイレクト先のページを確認する場合は以下の行を追加
        follow_redirect!
        # リダイレクト先のページが正常であることを確認
        expect(response).to have_http_status(:success)
      end
    end

    # 異常系
    context "when invalid parameters" do
      it "does not create a user and renders errors" do
        post user_registration_path, params: {
          user: {
            email: '',  # 無効なメールアドレス
            password: 'password123',
            password_confirmation: 'password123',
            phone_number: '1234567890',
            birthdate: '2000-01-01'
          }
        }
        # リクエストが失敗し、エラーが返されることを確認
        expect(response).to have_http_status(:unprocessable_entity)
        # 応答にエラーメッセージが含まれていることを確認
        expect(response.body).to include('エラー')
      end
    end

  end
end