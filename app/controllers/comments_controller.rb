# frozen_string_literal: true

class CommentsController < ApplicationController
  def create
    @tweet = Tweet.find(params[:tweet_id])
    @comment = @tweet.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to tweet_path(@tweet), notice: 'Comment was successfully created.'
    else
      render 'tweets/show'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
