require 'rails_helper'

RSpec.describe 'PotsController', type: :request do
  describe 'GET users/:index/posts test' do
    before(:example) { get '/users/13/posts' }

    it 'should return a success response status' do
      expect(response).to have_http_status(:success)
    end

    it 'should display the Posts index view file' do
      expect(response).to render_template(:index)
    end

    it 'should include the header in the template file' do
      expect(response.body).to include('View to check all posts from a specific user')
    end
  end

  describe 'GET users/:id/posts' do
    before(:example) { get '/users/28/posts/2' }

    it 'should return a success response status' do
      expect(response).to have_http_status(:success)
    end

    it 'should display the Users show view file' do
      expect(response).to render_template('posts/show')
    end

    it 'should include the header in the template file' do
      expect(response.body).to include('View to check a specific post from a specific user')
    end
  end
end
