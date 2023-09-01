# frozen_string_literal: true

class User < ApplicationRecord
  # userモデルでdeviseのすべてのmoduleを有効にする
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :confirmable, :lockable,
         :timeoutable, :trackable, :omniauthable, omniauth_providers: %i[github]

  # バリデーション
  validates :email, presence: true
  validates :phone_number, presence: true, unless: :omniauth_user?
  validates :birthdate, presence: true, unless: :omniauth_user?

  # Omniauth認証時の処理
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_initialize do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.phone_number = 'N/A'
      user.birthdate = '2000-01-01'
      user.confirmed_at = Time.now.utc
      user.save!
    end
  end

  # Omniauthで認証されたユーザーかどうかを判定
  def omniauth_user?
    provider.present? && uid.present?
  end
end

# ### userモデルでdeviseのすべてのmoduleを有効にする
# ・database_authenticatable: パスワードのセキュアな保存と認証を担当します。
# ・registerable: ユーザーの登録やアカウント削除などを扱います。
# ・recoverable: パスワードリセット機能を提供します。
# ・rememberable: ユーザーのセッションを長く保持する「Remember me」機能を提供します。
# ・validatable: Eメールやパスワードのバリデーションを行います。
# ・confirmable: メールアドレスの確認を行います。
# ・lockable: 複数回のログイン失敗でアカウントをロックする機能を提供します。
# ・timeoutable: 一定時間アクションがない場合、セッションをタイムアウトさせる機能を提供します。
# ・trackable: ユーザーのサインインカウントや時刻、IPアドレスをトラックします。
# ・omniauthable: OAuth 2.0を使用してのサードパーティ認証をサポートします。
