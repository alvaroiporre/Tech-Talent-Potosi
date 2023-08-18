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
    post = user

