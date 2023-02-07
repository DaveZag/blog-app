require 'rails_helper'

RSpec.describe 'Post index page', type: :system do
  before do
    driven_by(:rack_test)

    user = User.create(name: 'John Doe', photo: 'https://pic.com/890987655', bio: 'Hi there')
    Post.create(author: user, title: 'Hello from Mars',
                text: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry.')
    @post = Post.create(author: user, title: 'Hello there', text: 'This is my first post')
    @comment = Comment.create(text: 'Hello', author: user, post: @post)

    visit user_posts_path(user.id)
  end

  context 'When visiting the post index page' do
    it "should load the user's name" do
      expect(page).to have_content('John Doe')
    end

    it 'should load the number of posts by the user' do
      expect(page).to have_content('Number of Posts: 2')
    end

    it "should load the post's title" do
      expect(page).to have_content('Hello from Mars')
    end

    it 'should show posts bodies' do
      expect(page).to have_content(@post.text)
    end

    it 'should show posts last comments' do
      expect(page).to have_content(@comment.text)
    end
  end
end
