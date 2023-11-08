# spec/system/signup_spec.rb

require 'rails_helper'

RSpec.describe "User Signup", type: :system do

  # テストが始まる前に実行される
  before do
    # JavaScriptを無効にする
    driven_by(:rack_test)
  end

  context "with valid credentials" do
    it "allows a user to sign up and redirects to the login page" do
      # visit：指定されたパスにブラウザを移動
      visit new_user_registration_path
      # fill_in：指定されたラベルの入力フィールドに値を入力
      fill_in "user_email", with: "user@example.com"
      fill_in "user_password", with: "password123"
      fill_in "user_password_confirmation", with: "password123"
      fill_in "user_phone_number", with: "1234567890"
      fill_in "user_birthdate", with: "2000-01-01"
      click_button "Sign up"
      expect(current_path).to eq root_path # ルートページにリダイレクトされることを確認
    end
  end

  context "with invalid credentials" do
    it "does not allow a user to sign up and shows error messages" do
      visit new_user_registration_path
      fill_in "user_email", with: "user@example.com"
      fill_in "user_password", with: "password123"
      fill_in "user_password_confirmation", with: "password"
      fill_in "user_phone_number", with: "1234567890"
      fill_in "user_birthdate", with: "2000-01-01"
      click_button "Sign up"
      expect(page).to have_content "パスワード（確認用）とパスワードの入力が一致しません" # 実際に表示されるエラーメッセージを期待する
    end
  end
end
