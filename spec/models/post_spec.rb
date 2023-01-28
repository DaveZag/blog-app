require 'rails_helper'

RSpec.describe Post, type: :model do
  before(:all) do
    @user = User.create(name: 'John Doe', photo: 'https://unsplash.com/photos/F_-10BxGuVvo', bio: 'Hi there')
    @post = Post.create(author: @user, title: 'Hello there', text: 'This is my first post')
  end

  context 'When validating' do
    it 'title should be valid if not nil' do
      expect(@post).to be_valid
    end

    it 'title should be invalid if its value is nil' do
      @post.title = nil
      expect(@post).not_to be_valid
    end

    it 'title should be invalid when value exceeds 250 characters' do
      title = 'Lorem ipsum dolor sit amet consectetur adipisicing elit. Aut itaque consectetur
      voluptates earum voluptatem officiis, a natus hic maiores dolore. Ab iste aut corrupti perspiciatis minima?
      Ea reprehenderit adipisci molestias nihil totam sit consectetur magni atque ipsum quo. Aspernatur,
      debitis similique possimus magnam nulla animi esse reprehenderit quis nihil veritatis velit ad blanditiis
      repellendus omnis reiciendis quibusdam iure quas molestiae tempore, error ipsa.'
      @post.title = title
      expect(@post).not_to be_valid
    end

    it 'should have a valid author_id' do
      expect(@post.author_id).to be_an(Integer)
    end
  end

  context 'When post is being saved' do
    before { @post.save }

    it 'should increment posts_counter in user' do
      expect(User.find(@user.id).posts_counter).to_not eq 0
    end
  end

  context 'When #latest_comments is called' do
    before { 6.times { Comment.create(post: @post, author: @user, text: 'I am new here') } }

    it 'should return an array of length 5' do
      expect(@post.latest_comments.length).to eq 5
    end
  end
end
