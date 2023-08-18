class Like < ApplicationRecord
    belongs_to :author, class_name: 'User'
    belongs_to :post

    after_create :update_post_likes_counter
  before_destroy :update_post_likes_counter_before_destroy

  def update_post_likes_counter
    post.increment!(:likes_counter)
  end

  def update_post_likes_counter_before_destroy
    post.decrement!(:likes_counter)
  end
end
