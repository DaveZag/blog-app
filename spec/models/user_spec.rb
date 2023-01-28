require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'John Doe', photo: 'https://unsplash.com/photos/F_-10BxGuVvo', bio: 'Hi there') }

  context 'when validating' do
    it 'should be valid' do
      expect(subject).to be_valid
    end

    it 'should be invalid' do
      subject.name = ''
      expect(subject).to_not be_valid
    end
  end

  context 'latest_post method' do
    before { 4.times { Post.create(author: subject, title: 'Kuku', text: 'This is my first post again') } }

    it 'should retun the 3 latest posts' do
      expect(subject.latest_posts.length).to eq 3
    end
  end
end
