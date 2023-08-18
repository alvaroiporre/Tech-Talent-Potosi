class Comment < ApplicationRecord
    validates :text, presence: true

    belongs_to :author, class_name: 'User'
    belongs_to :post
end
