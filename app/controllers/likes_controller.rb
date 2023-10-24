# frozen_string_literal: true

# app/controllers/likes_controller.rb
class LikesController < ApplicationController
  # いいねを付与する
  def create
    @tweet = Tweet.find(params[:tweet_id])
    @like = @tweet.likes.build(user_id: current_user.id)

    ActiveRecord::Base.transaction do
      @like.save!

      # いいねの通知を作成する
      Notification.create!(
        user: @tweet.user,  # いいねされた(通知先)ユーザー
        actionable: @like   # 通知の種類、ツイートIDの二つの情報を持つ(polymorphic)
      )

      # メールの送信を行う
      NotificationMailer.notify_user(@tweet.user, @like).deliver_now
    end

    # 現在のページにアクセスする前にいたページにリダイレクトする。
    redirect_to request.referer || root_path
  rescue ActiveRecord::RecordInvalid
    # ここでエラーメッセージ等を設定しても良い
    redirect_to request.referer || root_path
  end

  ## いいねを解除する
  def destroy
    @tweet = Tweet.find(params[:tweet_id])
    @like = @tweet.likes.find_by(user_id: current_user.id)
    @like.destroy
    # 現在のページにアクセスする前にいたページにリダイレクトする
    redirect_to request.referer || root_path
  end
end
