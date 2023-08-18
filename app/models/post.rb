class Post < ApplicationRecord
  validates :title, presence: true
  validates :text, presence: true
  validates :comments_counter, presence: true, numericality: { only_integer: true }
  validates :likes_counter, presence: true, numericality: { only_integer: true }

  belongs_to :author, class_name: 'User'
  has_many :comments
  has_many :likes

  after_create :update_user_posts_counter
  before_destroy :update_user_posts_counter

  def update_user_posts_counter
    author.increment!(:posts_counter)
  end

  def update_user_posts_counter_before_destroy
    author.decrement!(:posts_counter)
  end

  def recent_comments(limit = 5)
    comments.order(created_at: :desc).limit(limit)
  end
end
