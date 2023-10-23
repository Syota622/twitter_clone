# frozen_string_literal: true

class CommentsController < ApplicationController
  # コメントを作成する
  def create
    @tweet = Tweet.find(params[:tweet_id])
    @comment = @tweet.comments.new(comment_params)
    @comment.user = current_user
  
    ActiveRecord::Base.transaction do
      @comment.save!
  
      # コメントの通知を作成する
      Notification.create!(
        user: @tweet.user, # コメントされた(通知先)ユーザー
        actionable: @comment # 通知の種類、ツイートIDの二つの情報を持つ(polymorphic)
      )
  
      # メールの送信を行う
      NotificationMailer.notify_user(@tweet.user, @comment).deliver_now
    end
  
    # tweet_pathへリダイレクト
    redirect_to tweet_path(@tweet), notice: 'Comment was successfully created.'
  
  rescue ActiveRecord::RecordInvalid
    render 'tweets/show'
  end  

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
