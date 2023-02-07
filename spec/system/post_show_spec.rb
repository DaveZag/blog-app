require 'rails_helper'

RSpec.describe "Post show page" , type: :system do
    before do
        driven_by(:rack_test)
        user = User.create(name: 'John Doe', photo: 'https://pic.com/890987655', bio: 'Hi there')
        @post = Post.create(author: user, title: 'Hello from Mars', text: 'This is my first post')
    
        visit user_post_path(user, @post)
    end
    
    context "When visiting the post show page" do
        it "should display the post's title" do
            expect(page).to have_content(@post.title)
        end
        
        it "should display the author's name" do
            expect(page).to have_content('John Doe')
        end
        
        it "should display the number of comments" do
            expect(page).to have_content('Comments: 0') 
        end
        it "should display the number of likes" do
            expect(page).to have_content('Likes: 0') 
        end
        it "should display the post's body" do
            expect(page).to have_content(@post.text) 
        end
        
        it "should display the comments pusblished" do
            @post.comments.each do |comment|
                expect(page).to have_content(comment.text)
                expect(page).to have_content(comment.user.name)
            end   
        end
        
    end
end