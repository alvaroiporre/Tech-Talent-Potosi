# spec/models/like_spec.rb
require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user) { User.create(name: "John Doe", photo: "john.jpg", bio: "A developer", posts_counter: 0) }
  let(:post) { user.posts.create(title: "My Post", text: "This is a post", comments_counter: 0, likes_counter: 0) }

  it "updates post's likes_counter after create" do
    expect(post.likes_counter).to eq(0)
    like = post.likes.create(author: user)
    post.reload
    expect(post.likes_counter).to eq(1)
  end

  it "updates post's likes_counter before destroy" do
    like = post.likes.create(author: user)
    expect(post.likes_counter).to eq(1)
    like.destroy
    post.reload
    expect(post.likes_counter).to eq(0)
  end
end
