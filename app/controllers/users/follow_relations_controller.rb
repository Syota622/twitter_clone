# frozen_string_literal: true

# app/controllers/follow_relations_controller.rb
module Users
  class FollowRelationsController < ApplicationController
    # ユーザーをフォローする
    def create
      @user = User.find(params[:user_id])
      @follow_relation = current_user.follower_relations.build(followee_id: @user.id)
      Rails.logger.debug("@follow_relation_create: #{@follow_relation.inspect}")

      @follow_relation.save
      redirect_to request.referer || root_path
    end

    # フォローを解除する
    def destroy
      @user = User.find(params[:user_id])
      Rails.logger.debug("@user: #{@user.inspect}")
      @follow_relation = current_user.follower_relations.find_by(followee_id: @user.id)
      Rails.logger.debug("@follow_relation_destroy: #{@follow_relation.inspect}")
      @follow_relation.destroy
      redirect_to request.referer || root_path
    end
  end
end
