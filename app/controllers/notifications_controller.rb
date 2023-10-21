# frozen_string_literal: true

class NotificationsController < ApplicationController
  # ログインユーザーに紐づく通知一覧を取得する
  def index
    @notifications = current_user.notifications
  end
end
