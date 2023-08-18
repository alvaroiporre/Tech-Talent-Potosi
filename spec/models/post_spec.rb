require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { User.create(name: "John Doe", photo: "john.jpg", bio: "A developer", posts_counter: 0) }

  it "is valid with valid attributes" do
    post = user.posts.new(title: "My Post", text: "This is a post", comments_counter: 0, likes_counter: 0)
    expect(post).to be_valid
  end

  it "is not valid without a title" do
    post = user.posts.new(text: "This is a post", comments_counter: 0, likes_counter: 0)
    expect(post).not_to be_valid
  end

  it "is not valid without text" do
    post = user.posts.new(title: "My Post", comments_counter: 0, likes_counter: 0)
    expect(post).not_to be_valid
  end

  it "is valid with maximum title length" do
    post = user.posts.new(title: "x" * 250, text: "This is a post", comments_counter: 0, likes_counter: 0)
    expect(post).to be_valid
  end

  it "is not valid with title exceeding maximum length" do
    post = user.posts.new(title: "x" * 251, text: "This is a post", comments_counter: 0, likes_counter: 0)
    expect(post).not_to be_valid
  end

  it "is not valid with negative comments_counter" do
    post = user.posts.new(title: "My Post", text: "This is a post", comments_counter: -1, likes_counter: 0)
    expect(post).not_to be_valid
  end

  it "is valid with zero comments_counter" do
    post = user.posts.new(title: "My Post", text: "This is a post", comments_counter: 0, likes_counter: 0)
    expect(post).to be_valid
  end

  it "is valid with positive comments_counter" do
    post = user.posts.new(title: "My Post", text: "This is a post", comments_counter: 10, likes_counter: 0)
    expect(post).to be_valid
  end

  it "is not valid with negative likes_counter" do
    post = user.posts.new(title: "My Post", text: "This is a post", comments_counter: 0, likes_counter: -1)
    expect(post).not_to be_valid
  end

  it "is valid with zero likes_counter" do
    post = user.posts.new(title: "My Post", text: "This is a post", comments_counter: 0, likes_counter: 0)
    expect(post).to be_valid
  end

  it "is valid with positive likes_counter" do
    post = user.posts.new(title: "My Post", text: "This is a post", comments_counter: 0, likes_counter: 10)
    expect(post).to be_valid
  end

  it "updates user's posts_counter after create" do
    expect(user.posts_counter).to eq(0)
    post = user.posts.create(title: "My Post", text: "This is a post", comments_counter: 0, likes_counter: 0)
    user.reload
    expect(user.posts_counter).to eq(1)
  end

  it "updates user's posts_counter before destroy" do
    post = user.posts.create(title: "My Post", text: "This is a post", comments_counter: 0, likes_counter: 0)
    expect(user.posts_counter).to eq(1)
    post.destroy
    user.reload
    expect(user.posts_counter).to eq(0)
  end

  it "returns the 5 most recent comments" do
    post = user.posts.create(title: "My Post", text: "This is a post", comments_counter: 0, likes_counter: 0)
    comment1 = post.comments.create(text: "Comment 1", author: user)
    comment2 = post.comments.create(text: "Comment 2", author: user)
    comment3 = post.comments.create(text: "Comment 3", author: user)
    comment4 = post.comments.create(text: "Comment 4", author: user)
    comment5 = post.comments.create(text: "Comment 5", author: user)
    comment6 = post.comments.create(text: "Comment 6", author: user)

    recent_comments = post.recent_comments(5)
    expect(recent_comments).to eq([comment6, comment5, comment4, comment3, comment2])
  end
end
