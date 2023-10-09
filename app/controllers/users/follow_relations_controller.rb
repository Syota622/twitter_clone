# frozen_string_literal: true

# app/controllers/follow_relations_controller.rb
module Users
  class FollowRelationsController < ApplicationController
    # ユーザーをフォローする
    def create
      @user = User.find(params[:user_id])
      # ログインしたユーザーが、@userをフォローする
      @follow_relation = current_user.followee_relations.build(follower_id: @user.id)
      @follow_relation.save
      redirect_to request.referer || root_path
    end

    # フォローを解除する
    def destroy
      @user = User.find(params[:user_id])
      # ログインしたユーザーが、@userのフォローを解除する
      @follow_relation = current_user.followee_relations.find_by(follower_id: @user.id)
      @follow_relation.destroy
      redirect_to request.referer || root_path
    end
  end
end
