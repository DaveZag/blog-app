require 'rails_helper'

RSpec.describe 'Show page', type: :system do
  before(:each) do
    driven_by(:rack_test)
    @user = User.create(name: 'VITS', photo: 'https:123', bio: 'A software developer based in Kenya', posts_counter: 0)
    3.times do |a|
      @posts = Post.create(author_id: @user.id, title: "#{a} Post", text: 'hello', comments_counter: 0,
                           likes_counter: 0)
    end
  end
  context 'render user show page' do
    it 'show content in user' do
      visit user_path(@user)
      expect(page).to have_content(@user.name)
      expect(page).to have_content('A software developer based in Kenya')
      expect(page).to have_xpath("//img[@src='#{@user.photo}']")
      expect(page).to have_content(@user.posts_counter)
    end
    it 'show three posts' do
      driven_by(:rack_test)
      visit user_path(@user)
      expect(page).to have_css('.post-card', count: 3)
    end

    it 'button for user posts' do
      visit user_path(@user)
      expect(page).to have_link 'See all posts'
    end

    it 'onclick redirect to posts show' do
      visit user_path(@user)
      click_link @posts.title, match: :first
      expect(page).to have_current_path("/users/#{@user.id}/posts/#{@posts.id}")
    end

    it 'onclick redirect to posts index' do
      visit user_path(@user)
      click_link 'See all posts'
      expect(page).to have_current_path("/users/#{@user.id}/posts")
    end
  end
end
