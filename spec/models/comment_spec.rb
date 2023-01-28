require 'rails_helper'

RSpec.describe Comment, type: :model do
  user = User.create(name: 'John Doe', photo: 'https://unsplash.com/photos/F_-10BxGuVvo', bio: 'Hi there')
  post = Post.create(author: user, title: 'Hello', text: 'This is my first post?')
  subject { Comment.new(text: 'Good article', author: user, post:) }

  context 'when validating' do
    it 'should have a defined text' do
      expect(subject.text.length).to be > 0
    end

    it 'should not be valid if no text is found' do
      subject.text = ''
      expect(subject).to_not be_valid
    end
  end

  context 'when post is not saved' do
    after { subject.save }
    it 'comments_counter should be 0' do
      expect(Post.find(post.id).comments_counter).to be 0
    end
  end

  context 'when post is saved' do
    before { subject.save }
    it 'comments_counter should be incremented' do
      expect(Post.find(post.id).comments_counter).to be > 0
    end
  end
end
