# spec/system/sessions_spec.rb

require 'rails_helper'

RSpec.describe "User Login", type: :system do
  before do
    driven_by(:rack_test)

    # テスト用ユーザーを作成
    User.create!(email: 'user@example.com', password: 'password123', phone_number: '1234567890', birthdate: '2000-01-01')
  end

  context "with valid credentials" do
    it "allows a user to log in and redirects to the home page" do
      visit new_user_session_path
      fill_in "user_email", with: "user@example.com"
      fill_in "user_password", with: "password123"
      click_button "Log in"

      expect(current_path).to eq dashboard_path
    end
  end

  context "with invalid credentials" do
    it "does not allow a user to log in and stays on the login page" do
      visit new_user_session_path
      fill_in "user_email", with: "user@example.com"
      fill_in "user_password", with: "incorrect_password"
      click_button "Log in"

      expect(current_path).to eq new_user_session_path # ログインページに留まることを確認
    end
  end
end
