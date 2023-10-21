# frozen_string_literal: true

# app/controllers/likes_controller.rb
class LikesController < ApplicationController
  # いいねを付与する
  def create
    @tweet = Tweet.find(params[:tweet_id])
    @like = @tweet.likes.build(user_id: current_user.id)
    @like.save
    # 現在のページにアクセスする前にいたページにリダイレクトする。
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
