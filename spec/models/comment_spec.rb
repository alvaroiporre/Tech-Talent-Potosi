require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) do
    User.create(name: 'Tom',
                photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                bio: 'Teacher from Mexico.',
                posts_counter: 0)
  end

  let(:post) do
    user.posts.create(title: 'Hello Post',
                      comments_counter: 0,
                      likes_counter: 0)
  end

  subject do
    described_class.new(
      author: user,
      post:,
      text: 'Lovely post!'
    )
  end

  describe 'associations' do
    it 'belongs to an author' do
      association = described_class.reflect_on_association(:author)
      expect(association.macro).to eq(:belongs_to)
    end

    it 'belongs to a post' do
      association = described_class.reflect_on_association(:post)
      expect(association.macro).to eq(:belongs_to)
    end
  end

  describe 'counter updates' do
    it 'increments comments_counter on comment creation' do
      expect do
        subject.save
      end.to change { post.reload.comments_counter }.by(1)
    end

    it 'decrements comments_counter on comment destruction' do
      comment = subject
      comment.save

      expect do
        comment.destroy
      end.to change { post.reload.comments_counter }.by(-1)
    end
  end
end