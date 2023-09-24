# frozen_string_literal: true

class TweetsController < ApplicationController
  # current_user：deviseが提供するヘルパーメソッド。現在ログインしているユーザーのインスタンスを返す。
  def index
    @tab = params[:tab] || 'recommend' # GET パラメータから選択したタブを取得（デフォルトは 'recommend'）
    # 全ツイートのページネーション
    @tweets_all = Tweet.all.order(created_at: :desc).page(params[:page_recommend])
    # フォロー中のユーザーのツイートのページネーション
    return unless user_signed_in?

    @tweets_following = current_user.following_tweets.order(created_at: :desc).page(params[:page_following])
  end

  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = current_user.tweets.build(tweet_params)
    if @tweet.save
      redirect_to tweets_path, notice: 'ツイートしました'
    else
      render :new
    end
  end

  private

  def content_or_image_present?
    return unless content.blank? && image.blank?

    errors.add(:base, 'Content or image must be present')
  end

  def tweet_params
    params.require(:tweet).permit(:content, :image)
  end
end
