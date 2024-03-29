# frozen_string_literal: true

class ProfilesController < ApplicationController
  # authenticate_user!メソッドは、ログインしていないユーザーをログイン画面にリダイレクトする
  before_action :authenticate_user!
  before_action :set_user, only: %i[show edit update]

  def show
    @tweets = @user.tweets.order(created_at: :desc)                 # ユーザーのツイートを取得
    @liked_tweets = @user.liked_tweets.order(created_at: :desc)     # いいねしたツイートを取得
    @retweets = @user.retweeted_tweets.order(created_at: :desc)     # リツイートしたツイートを取得
    @comments = @user.comments.order(created_at: :desc)             # コメントしたツイートを取得
    @tweets_with_likes_count = Tweet.joins(:likes).group(:id).count # いいね数を取得
    @tweets_with_retweets_count = Tweet.joins(:retweets).group(:id).count # リツイート数を取得
  end

  def edit; end

  def update
    if @user.update(user_params)
      # 更新が成功した場合、プロフィール画面にリダイレクト
      redirect_to profile_path(@user), notice: 'プロフィールを更新しました'
    else
      # 更新が失敗した場合、editテンプレートを再表示
      render :edit
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :bio, :location, :website, :birthdate, :phone_number)
  end
end
