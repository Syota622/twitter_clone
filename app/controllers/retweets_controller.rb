# frozen_string_literal: true

# app/controllers/retweets_controller.rb
class RetweetsController < ApplicationController
  # リツイートする
  def create
    @tweet = Tweet.find(params[:tweet_id])
    @retweet = @tweet.retweets.build(user_id: current_user.id)
    @retweet.save
    # 現在のページにアクセスする前にいたページにリダイレクトする。
    redirect_to request.referer || root_path
  end

  # リツイートを解除する
  def destroy
    @tweet = Tweet.find(params[:tweet_id])
    @retweet = @tweet.retweets.find_by(user_id: current_user.id)
    @retweet.destroy
    # 現在のページにアクセスする前にいたページにリダイレクトする
    redirect_to request.referer || root_path
  end
end
