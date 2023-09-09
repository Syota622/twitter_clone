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
end
