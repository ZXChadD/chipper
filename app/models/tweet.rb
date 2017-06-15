class Tweet < ApplicationRecord
  belongs_to :user
  has_many :replies, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :tweet_tags, dependent: :destroy
  has_many :tags, through: :tweet_tags

  validates :body, presence: true

  def self.tagged_with(name)
    Tag.find_by!(name: name).tweets
  end

  def all_tags=(names)
    self.tags = names.split(',').map do |name|
      Tag.where(name: name).first_or_create!
    end
  end

  def all_tags
    tags.map(&:name).join(', ')
  end
  
  def self.search(search)
    where('body ILike ?', "%#{search}%")
  end
end
