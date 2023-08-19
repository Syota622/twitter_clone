# frozen_string_literal: true

class User < ApplicationRecord
  # userモデルでdeviseのすべてのmoduleを有効にする
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :confirmable, :lockable,
         :timeoutable, :trackable, :omniauthable

  validates :email, presence: true
  validates :phone_number, presence: true
  validates :birthdate, presence: true
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
