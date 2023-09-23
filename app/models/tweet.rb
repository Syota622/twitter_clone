# frozen_string_literal: true

class Tweet < ApplicationRecord
  belongs_to :user
  # いいね機能の実装
  has_many :likes, dependent: :destroy
  has_many :liked_by_users, through: :likes, source: :user
  # リツイート機能の実装
  has_many :retweets, dependent: :destroy
  has_many :retweeters, through: :retweets, source: :user
  # コメント機能の実装
  has_many :comments, dependent: :destroy
end
