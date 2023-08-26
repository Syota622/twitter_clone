# frozen_string_literal: true

module Users
  # 外部のサービス（このケースではGitHub）を使用して認証を試みた後に呼び出されるコールバックを処理するコントローラー
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    # GitHubからのレスポンスを取得
    def github
      # @userにGitHubからのレスポンスを格納
      @user = User.from_omniauth(request.env['omniauth.auth'])

      # @userが既に登録済みの場合はログイン処理を行い、未登録の場合は新規登録画面へリダイレクト
      if @user.persisted?
        sign_in_and_redirect @user, event: :authentication
        set_flash_message(:notice, :success, kind: 'GitHub') if is_navigational_format?
      else
        session['devise.github_data'] = request.env['omniauth.auth']
        redirect_to new_user_registration_url
      end
    end

    def failure
      redirect_to root_path
    end
  end
end
