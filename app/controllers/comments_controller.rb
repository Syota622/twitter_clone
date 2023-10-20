# frozen_string_literal: true

class CommentsController < ApplicationController
  def create
    @tweet = Tweet.find(params[:tweet_id])
    @comment = @tweet.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      # tweet_pathへリダイレクト
      redirect_to tweet_path(@tweet), notice: 'Comment was successfully created.'

      # コメントの通知を作成する
      Notification.create!(
        user: @tweet.user,  # コメントされた(通知先)ユーザー
        actionable: @comment   # 通知の種類、ツイートIDの二つの情報を持つ(polymorphic)
      )
      # メールの送信を行う
      NotificationMailer.notify_user(@tweet.user, @comment).deliver_now
    else
      render 'tweets/show'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
