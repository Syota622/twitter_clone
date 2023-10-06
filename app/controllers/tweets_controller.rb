# frozen_string_literal: true

class TweetsController < ApplicationController
  # current_user：deviseが提供するヘルパーメソッド。現在ログインしているユーザーのインスタンスを返す。
  def index
    @tab = params[:tab] || 'recommend' # GET パラメータから選択したタブを取得（デフォルトは 'recommend'）
    # 全ツイートのページネーション
    @tweets_all = Tweet.all.order(created_at: :desc).page(params[:page_recommend])
    # いいね数を取得
    @tweets_with_likes_count = Tweet.joins(:likes).group(:id).count 
    # リツイート数を取得
    @tweets_with_retweets_count = Tweet.joins(:retweets).group(:id).count 

    # フォロー中のユーザーのツイートのページネーション
    return unless user_signed_in?

    @tweets_following = current_user.following_tweets.order(created_at: :desc).page(params[:page_following])
  end

  def show
    # @tweetを取得する際に、関連するuserも同時に取得する（N+1問題対策）
    @tweet = Tweet.includes(:user).find(params[:id])

    # @tweetに関連するcommentsを取得する際に、関連するuserも同時に取得する（N+1問題対策）
    @comments = @tweet.comments.includes(:user).order(created_at: :desc)
    @comment = Comment.new

    # いいねの数を取得
    @tweets_with_likes_count = Tweet.joins(:likes).group(:id).count
    # リツイート数を取得
    @tweets_with_retweets_count = Tweet.joins(:retweets).group(:id).count 
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

  def tweet_params
    params.require(:tweet).permit(:content, :image)
  end
end

# @tweets_with_retweets_count = Tweet.joins(:retweets).group(:id).count 
# irb(main):004:0> Tweet.joins(:likes).group(:id).count
#   Tweet Count (4.0ms)  SELECT COUNT(*) AS "count_all", "tweets"."id" AS "tweets_id" FROM "tweets" INNER JOIN "likes" ON "likes"."tweet_id" = "tweets"."id" GROUP BY "tweets"."id"
# =>
# {595=>1,
#  574=>1,
#  601=>2,
#  590=>1,
#  616=>2,
#  603=>1,
#  591=>1,
#  586=>2,
#  607=>1,
#  572=>2,
#  606=>1,
#  587=>2,
#  618=>1,
#  582=>1,
#  597=>1,
#  610=>1,
#  592=>2,
#  573=>1,
#  614=>1,
#  605=>1,
#  602=>2,
#  596=>1,
#  581=>1,
#  609=>1,
#  583=>1,
#  615=>2,
#  612=>1,
#  600=>2,
#  585=>1,
#  604=>3}