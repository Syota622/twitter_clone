# frozen_string_literal: true

class ProfilesController < ApplicationController
  def show
    @user = User.find(params[:id])
    @tweets = @user.tweets.order(created_at: :desc)
    @liked_tweets = @user.liked_tweets.order(created_at: :desc)
    @retweets = @user.retweeted_tweets.order(created_at: :desc)
    @comments = @user.comments.order(created_at: :desc)
  end
end
