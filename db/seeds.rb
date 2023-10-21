# frozen_string_literal: true

# db/seeds.rb

# 全ユーザーのプロフィール画像を削除
ActiveStorage::Attachment.delete_all
ActiveStorage::Blob.delete_all

# テーブルのデータを削除
FollowRelation.delete_all
Bookmark.delete_all
Notification.delete_all
Comment.delete_all
Like.delete_all
Retweet.delete_all
Tweet.delete_all
User.delete_all

# ユーザー作成
users = []
1.upto(7) do |i|
  user = User.create!(
    email: "user#{i}@example.com",
    password: 'password',
    password_confirmation: 'password',
    phone_number: '12345678',
    birthdate: '1990-01-01',
    name: "User #{i}",
    bio: "This is User #{i}'s bio.",
    location: "City #{i}",
    website: "http://user#{i}.website.com"
  )

  # プロフィール画像を添付
  user.profile_image.attach(
    io: File.open(Rails.root.join('app', 'assets', 'images', 'profile', "image#{i}.png")),
    filename: "image#{i}.png",
    content_type: 'image/png'
  )

  # header画像を添付
  user.header_image.attach(
    io: File.open(Rails.root.join('app', 'assets', 'images', 'header', "image#{i}.png")),
    filename: "image#{i}.png",
    content_type: 'image/png'
  )
  users << user
end

# ツイート作成
users.each_with_index do |user, index|
  1.upto(7) do |j|
    Tweet.create!(content: "user#{index + 1}のツイート#{j}", user: user)  # `user:`の部分を修正
  end
end

# 「いいね」「リツイート」「コメント」作成
users.each do |user|
  # 自分のツイートを除外する
  tweets_for_likes = Tweet.where.not(user_id: user.id).to_a.shuffle
  tweets_for_likes.first(2).each do |tweet|
    like = Like.create!(user_id: user.id, tweet_id: tweet.id)
    
    # 通知を作成
    Notification.create!(
      user: tweet.user,
      actionable: like
    ) if tweet.user != user
  end

  tweets_for_retweets = Tweet.where.not(user_id: user.id).to_a.shuffle
  tweets_for_retweets.first(2).each do |tweet|
    retweet = Retweet.create!(user_id: user.id, tweet_id: tweet.id)
    
    # 通知を作成
    Notification.create!(
      user: tweet.user,
      actionable: retweet
    ) if tweet.user != user 
  end

  tweets_for_comments = Tweet.where.not(user_id: user.id).to_a.shuffle
  tweets_for_comments.first(2).each do |tweet|
    comment = Comment.create!(content: "user#{user.id}のコメント", user: user, tweet: tweet)
    
    # 通知を作成
    Notification.create!(
      user: tweet.user,
      actionable: comment
    ) if tweet.user != user
  end
end

# フォロー関係作成
FollowRelation.create!(follower_id: users[0].id, followee_id: users[2].id)
FollowRelation.create!(follower_id: users[0].id, followee_id: users[4].id)
FollowRelation.create!(follower_id: users[1].id, followee_id: users[0].id)
FollowRelation.create!(follower_id: users[1].id, followee_id: users[3].id)
FollowRelation.create!(follower_id: users[2].id, followee_id: users[1].id)
FollowRelation.create!(follower_id: users[2].id, followee_id: users[4].id)
FollowRelation.create!(follower_id: users[3].id, followee_id: users[0].id)
FollowRelation.create!(follower_id: users[3].id, followee_id: users[1].id)
FollowRelation.create!(follower_id: users[3].id, followee_id: users[2].id)
FollowRelation.create!(follower_id: users[4].id, followee_id: users[0].id)
FollowRelation.create!(follower_id: users[4].id, followee_id: users[3].id)
FollowRelation.create!(follower_id: users[5].id, followee_id: users[1].id)
FollowRelation.create!(follower_id: users[5].id, followee_id: users[3].id)
FollowRelation.create!(follower_id: users[5].id, followee_id: users[4].id)
FollowRelation.create!(follower_id: users[6].id, followee_id: users[0].id)
FollowRelation.create!(follower_id: users[6].id, followee_id: users[5].id)

###
# フォロー関係作成
# users[2] は users[0] をフォローしている。users[0]は users[2]のフォロワー。
# users[0] は users[1] をフォローしている。users[1]は users[0]のフォロワー。
# users[1] は users[2] をフォローしている。users[2]は users[1]のフォロワー。
