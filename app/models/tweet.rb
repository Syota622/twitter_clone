# frozen_string_literal: true

class Tweet < ApplicationRecord
  # バリデーションの設定
  validates :content, length: { maximum: 140 }

  # content と image のどちらかが存在することを検証する
  validate :content_or_image_present?

  # 画像アップロード機能の実装
  has_one_attached :image

  belongs_to :user
  # いいね機能の実装
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  # リツイート機能の実装
  has_many :retweets, dependent: :destroy
  has_many :retweeters, through: :retweets, source: :user
  # コメント機能の実装
  has_many :comments, dependent: :destroy

  private

  # content と image のどちらかが存在することを検証する
  def content_or_image_present?
    return unless content.blank? && image.blank?

    errors.add(:base, 'Content or image must be present')
  end
end
