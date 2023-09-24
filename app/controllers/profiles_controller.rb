# frozen_string_literal: true

class ProfilesController < ApplicationController
  # authenticate_user!メソッドは、ログインしていないユーザーをログイン画面にリダイレクトする
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update]

  def show
    # @user = User.find(params[:id])
    @tweets = @user.tweets.order(created_at: :desc)
    @liked_tweets = @user.liked_tweets.order(created_at: :desc)
    @retweets = @user.retweeted_tweets.order(created_at: :desc)
    @comments = @user.comments.order(created_at: :desc)
  end

  def edit
  end

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
