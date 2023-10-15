# frozen_string_literal: true

class BookmarksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_tweet, only: %i[create destroy]

  # ブックマークしたツイート一覧を表示する
  def index
    @user = current_user
    @bookmarked_tweets = Tweet.joins(:bookmarks).where(bookmarks: { user_id: @user.id })
    @tweets_with_retweets_count = Tweet.joins(:retweets).group(:id).count
    @tweets_with_likes_count = Tweet.joins(:likes).group(:id).count
  end

  # ブックマークの登録
  def create
    @bookmark = current_user.bookmarks.create(tweet: @tweet)
    redirect_to request.referer || root_path
  end

  # ブックマークの解除
  def destroy
    @bookmark = current_user.bookmarks.find_by(tweet_id: @tweet.id)
    @bookmark&.destroy
    redirect_to request.referer || root_path
  end

  private

  def set_tweet
    @tweet = Tweet.find(params[:tweet_id])
  end
end
