class Post < ApplicationRecord
    validates :title, presence: true
    validates :text, presence: true
    validates :comments_counter, presence: true, numericality: { only_integer: true }
    validates :likes_counter, presence: true, numericality: { only_integer: true }

    belongs_to :author, class_name: 'User'
    has_many :comments
    has_many :likes
end
