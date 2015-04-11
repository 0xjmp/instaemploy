require 'spec_helper'

describe Api::V1::UsersController do
  let(:user){create(:user)}

  shared_examples '#show' do
    it '#show' do
      get :show, id: user.id, format: :json
      expect(response).to have_http_status 200
      expect(assigns(:user)).to be
    end
  end

  context 'while logged out' do
    it '#index' do
      get :index, format: :json
      expect(response).to have_http_status 401
      expect(assigns(:user)).to_not be
    end

    it '#update' do
      put :update, id: user.id, user: attributes_for(:user), format: :json
      expect(response).to have_http_status 401
      expect(assigns(:user)).to_not be
    end

    include_examples '#show'
  end

  context 'while logged in' do
    user_mapping(:user)

    it '#index' do
      get :index, format: :json
      expect(response).to have_http_status 200
      expect(assigns(:user)).to be
      expect(response).to render_template('index')
    end

    it '#update' do
      put :update, id: user.id, user: attributes_for(:user), format: :json
      expect(response).to have_http_status 202
      expect(assigns(:user)).to be
    end

    include_examples '#show'
  end

end