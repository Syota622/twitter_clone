class ProfilesController < ApplicationController
  def show
    @user = User.find(params[:id])
    @tweets = @user.tweets.order(created_at: :desc)
  end
end
