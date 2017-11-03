class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable

  has_many :tweets, dependent: :destroy

  has_many :active_relationships, class_name: 'Relationship', foreign_key: :follower_id
  has_many :followees, through: :active_relationships

  has_many :passive_relationships, class_name: 'Relationship', foreign_key: :followee_id
  has_many :followers, through: :passive_relationships

  def follow(user)
    followees << user if !self.following?(user) && self != user
  end

  def unfollow(user)
    followees.delete(user)
  end

  def following?(user)
    followees.include?(user)
  end

  # Status feed
  def feed
    following_ids = "SELECT followee_id FROM relationships
                     WHERE  follower_id = :user_id"
    Tweet.where("user_id IN (#{following_ids})
                     OR user_id = :user_id", user_id: id)
  end

end
