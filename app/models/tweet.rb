class Tweet < ApplicationRecord

  has_many :tweet_tags, dependent: :destroy
  has_many :tags, through: :tweet_tags

  validates :body, presence: true

  belongs_to :user

end
