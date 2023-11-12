# spec/models/user_spec.rb

require 'rails_helper'

RSpec.describe User, type: :model do
  # emailがnilの場合にエラーになること
  it 'is invalid without an email' do
    user = User.new(email: nil)
    # ユーザーのバリデーションを実行するメソッド
    user.valid?
    # emailのエラーがあるかどうかを確認する
    expect(user.errors[:email]).to include("を入力してください")
  end

  context 'for a regular user' do
    it 'is invalid without a phone number' do
      user = User.new(phone_number: nil)
      user.valid?
      # phone_numberのエラーがあるかどうかを確認する
      expect(user.errors[:phone_number]).to include("を入力してください")
    end

    it 'is invalid without a birthdate' do
      user = User.new(birthdate: nil)
      user.valid?
      # birthdateのエラーがあるかどうかを確認する
      expect(user.errors[:birthdate]).to include("を入力してください")
    end
  end

  context 'for an omniauth user' do
    it 'does not require a phone number' do
      # phone_numberが、nilでもエラーにならないこと
      user = User.new(phone_number: nil)
      # user オブジェクトの omniauth_user? メソッドが呼ばれた場合には、常に true を返すように振る舞う
      allow(user).to receive(:omniauth_user?).and_return(true)
      # バリデーションを実行する
      user.valid?
      # phone_numberのエラーがないことを確認する
      expect(user.errors[:phone_number]).to be_empty
    end

    it 'does not require a birthdate' do
      user = User.new(birthdate: nil)
      allow(user).to receive(:omniauth_user?).and_return(true)
      user.valid?
      # birthdateのエラーがないことを確認する
      expect(user.errors[:birthdate]).to be_empty
    end
  end
end
