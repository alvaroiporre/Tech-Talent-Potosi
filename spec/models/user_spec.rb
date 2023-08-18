require 'rails_helper'

RSpec.describe User, type: :model do
  subject do
    User.new(
      name: 'Tom',
      photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
      bio: 'Teacher from Mexico.',
      posts_counter: 2
    )
  end

  before { subject.save }

  describe 'associations' do
    it 'has many posts' do
      post1 = subject.posts.create(title: 'Post 1')
      post2 = subject.posts.create(title: 'Post 2')

      expect(subject.posts).to eq([post1, post2])
    end
  end

  it 'is valid when name is present' do
    subject.name = 'John'
    expect(subject).to be_valid
  end

  it 'is not valid when name is not present' do
    subject.name = nil
    expect(subject).not_to be_valid
  end

  it 'returns the most recent posts' do
    post1 = subject.posts.create(title: 'Post 1',
                                 comments_counter: 0,
                                 likes_counter: 0)
    post2 = subject.posts.create(title: 'Post 2',
                                 comments_counter: 0,
                                 likes_counter: 0)

    expect(subject.recent_posts).to eq([post2, post1])
  end

  it 'returns up to the specified limit of posts' do
    subject.posts.create(title: 'Post 3',
                         comments_counter: 0,
                         likes_counter: 0)
    post2 = subject.posts.create(title: 'Post 4',
                                 comments_counter: 0,
                                 likes_counter: 0)
    post3 = subject.posts.create(title: 'Post 5',
                                 comments_counter: 0,
                                 likes_counter: 0)

    expect(subject.recent_posts(2)).to eq([post3, post2])
  end

  it 'is not valid when posts_counter is negative' do
    subject.posts_counter = -1
    expect(subject).to_not be_valid
  end
end