# frozen_string_literal: true

class Tweet < ApplicationRecord
  belongs_to :user
  has_many :likes
  # likesテーブルを経由して、liked_by_usersを定義
  has_many :liked_by_users, through: :likes, source: :user
end
