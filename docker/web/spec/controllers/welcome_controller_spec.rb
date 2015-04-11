require 'spec_helper'

describe WelcomeController do
  context 'while logged out' do
    it '#index' do
      get :index
      expect(response).to have_http_status 200
      expect(response).to render_template('index')
    end
  end

  context 'while logged in' do
    user_mapping(:user)

    it '#index' do
      get :index
      expect(response).to redirect_to "/explore"
    end
  end
end