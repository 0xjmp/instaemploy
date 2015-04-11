require 'spec_helper'

describe Api::V1::ExploreController do

  shared_examples '#index' do
    it '#index' do
      get :index, format: :json
      expect(response).to have_http_status 200
      expect(response).to render_template('index')
      expect(assigns(:projects)).to be
    end
  end

  context 'while logged in' do
    user_mapping(:user)

    include_examples '#index'
  end

  context 'while logged out' do
    include_examples '#index'
  end
end