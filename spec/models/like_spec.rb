require 'rails_helper'

RSpec.describe Like, type: :model do
  user = User.create(name: 'John DOe', photo: 'https://unsplash.com/photos/F_-10BxGuVvo', bio: 'Hi')
  post = Post.create(author: user, title: 'What else?', text: 'Asking the good questions.')
  subject { Like.new(author: user, post:) }

  context 'when validating' do
    it 'should be valid' do
      expect(subject).to be_valid
    end
  end

  context 'When like is saved' do
    before { subject.save }
    it 'should increment the likes_counter on Post' do
      expect(Post.find(post.id).likes_counter).to be > 0
    end
  end
end
