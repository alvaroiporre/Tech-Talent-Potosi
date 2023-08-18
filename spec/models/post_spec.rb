require 'rails_helper'

RSpec.describe Post, type: :model do
  subject do
    described_class.new(
      author: user,
      title: 'Hello Post',
      comments_counter: 0,
      likes_counter: 0
    )
  end

  let(:user) do
    User.create(name: 'Tom',
                photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                bio: 'Teacher from Mexico.',
                posts_counter: 3)
  end

  before do
    user.save
    subject.save
  end

  describe 'validations' do
    subject do
      described_class.new(
        author: user,
        title: 'Hello Post',
        comments_counter: 0,
        likes_counter: 0
      )
    end

    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without a title' do
      subject.title = nil
      expect(subject).not_to be_valid
    end

    it 'is not valid without comments_counter' do
      subject.comments_counter = nil
      expect(subject).not_to be_valid
    end

    it 'is not valid without likes_counter' do
      subject.likes_counter = nil
      expect(subject).not_to be_valid
    end
  end

  describe 'associations' do
    it 'belongs to an author' do
      association = described_class.reflect_on_association(:author)
      expect(association.macro).to eq(:belongs_to)
    end

    it 'has many comments' do
      association = described_class.reflect_on_association(:comments)
      expect(association.macro).to eq(:has_many)
    end

    it 'has many likes' do
      association = described_class.reflect_on_association(:likes)
      expect(association.macro).to eq(:has_many)
    end
  end

  describe 'counter updates' do
    it 'increments author posts_counter on creation' do
      expect do
        user.posts.create(title: 'Post 1',
                          comments_counter: 0,
                          likes_counter: 0)
      end.to change { user.reload.posts_counter }.from(4).to(5)
    end

    it 'decrements author posts_counter on destruction' do
      post = user.posts.create(title: 'Hello Post')
      expect { post.destroy }.to change { user.reload.posts_counter }.by(-1)
    end

    it 'increments comments_counter on comment creation' do
      expect do
        comment = subject.comments.build(author: user, text: 'Lovely post!')
        comment.save
      end.to change { subject.reload.comments_counter }.by(1)
    end

    it 'decrements comments_counter on comment creation' do
      comment = subject.comments.create(author: user, text: 'Lovely post!')
      expect { comment.destroy }.to change { subject.reload.comments_counter }.by(-1)
    end

    it 'increments likes_counter on like creation' do
      like = subject.likes.build(author: user)
      expect { like.save }.to change { subject.reload.likes_counter }.by(1)
      subject.update(likes_counter: 0)
    end

    it 'decrements likes_counter on like destruction' do
      like = subject.likes.create(author: user)
      expect { like.destroy }.to change { subject.reload.likes_counter }.by(-1)
    end
  end
end
