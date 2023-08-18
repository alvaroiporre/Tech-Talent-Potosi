require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { User.create(name: "John Doe", photo: "john.jpg", bio: "A developer", posts_counter: 0) }
  let(:post) { user.posts.create(title: "My Post", text: "This is a post", comments_counter: 0, likes_counter: 0) }

  it "is valid with valid attributes" do
    comment = post.comments.new(text: "Nice comment", author: user)
    expect(comment).to be_valid
  end

  it "is not valid without text" do
    comment = post.comments.new(author: user)
    expect(comment).not_to be_valid
  end

  it "updates post's comments_counter after create" do
    expect(post.comments_counter).to eq(0)
    comment = post.comments.create(text: "Nice comment", author: user)
    post.reload
    expect(post.comments_counter).to eq(1)
  end

  it "updates post's comments_counter before destroy" do
    comment = post.comments.create(text: "Nice comment", author: user)
    expect(post.comments_counter).to eq(1)
    comment.destroy
    post.reload
    expect(post.comments_counter).to eq(0)
  end
end
