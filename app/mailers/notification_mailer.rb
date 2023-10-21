# frozen_string_literal: true

class NotificationMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def notify_user(user, actionable)
    @user = user
    @actionable = actionable
    mail(to: @user.email, subject: '新しい通知があります')
  end
end
