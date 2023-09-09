# frozen_string_literal: true

module Users
  class RegistrationsController < Devise::RegistrationsController
    protected

    def update_resource(resource, params)
      # パスワードなしでプロフィールを更新できるようにする場合
      if params[:password].blank? && params[:password_confirmation].blank?
        resource.update_without_password(account_update_params)
      else
        super
      end
    end

    private

    def sign_up_params
      params.require(:user).permit(:email, :password, :password_confirmation, :profile_image)
    end

    def account_update_params
      params.require(:user).permit(:email, :password, :password_confirmation, :current_password, :profile_image)
    end
  end
end
