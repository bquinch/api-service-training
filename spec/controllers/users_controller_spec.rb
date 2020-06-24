require 'rails_helper'

RSpec.describe Api::UsersController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:user2) { FactoryBot.create(:user) }
  let(:user3) { FactoryBot.create(:user) }

  context 'GET index' do
    it 'gets the list of users' do
      user.save
      user2.save
      user3.save
      get :index
      json = JSON.parse(response.body)
      expect(response.status).to eq(200)
      expect(json.count).to eq(3)
    end
  end

  context 'GET show' do
    it 'get the user' do
      user.save
      get :show, params: { id: user.id }
      json = JSON.parse(response.body)
      expect(response.status).to eq(200)
      expect(json['email']).to eq('abitbol_george@gmail.com')
    end
  end

  context 'POST create' do
    it 'creates a user' do
      get :create, params: {
        first_name: user.first_name,
        last_name: user.last_name,
        email: user.email,
        password: user.password
      }
      json = JSON.parse(response.body)
      expect(response.status).to eq(200)
      expect(json['user']['email']).to eq(user.email)
      expect(json['user']['password']).to_not eq(user.password)
      expect(json['user']['password']).to_not eq(nil)
    end
  end

  context 'PATCH update' do
    it 'updates a user' do
      get :update, params: {
        id: user.id,
        first_name: 'Basile'
      }
      json = JSON.parse(response.body)
      expect(response.status).to eq(200)
      expect(json['user']['first_name']).to eq('Basile')
      expect(json['user']['first_name']).to_not eq(user.first_name)
      expect(json['user']['first_name']).to_not eq(nil)
    end
  end

  context 'DELETE destroy' do
    it 'destroys a user' do
      id = user.id
      user.save
      get :destroy, params: { id: id }
      json = JSON.parse(response.body)
      expect(response.status).to eq(200)
      expect(json['message']).to eq('Record deleted')
    end
  end
end
