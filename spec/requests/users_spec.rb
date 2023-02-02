require 'rails_helper'

RSpec.describe 'UsersController', type: :request do
  describe 'GET users/' do
    before(:example) { get '/users/' }

    it 'should return a success response status' do
      expect(response).to have_http_status(:success)
    end

    it 'should display the user index view file' do
      expect(response).to render_template(:index)
    end

    it 'should include the header in the template file' do
      expect(response.body).to include('View to check all users')
    end
  end

  describe 'GET users/:id' do
    before(:example) { get '/users/28' }

    it 'should return a success response status' do
      expect(response).to have_http_status(:success)
    end

    it 'should display the Users show view file' do
      expect(response).to render_template('users/show')
    end

    it 'should include the header in the template file' do
      expect(response.body).to include('View to check a single user')
    end
  end
end
