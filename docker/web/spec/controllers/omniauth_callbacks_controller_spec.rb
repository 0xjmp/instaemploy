require 'spec_helper'

describe OmniauthCallbacksController do
  user_mapping(:user)

  context '#github' do
    it 'while logged in' do
      get :create, provider: 'github'
      expect(assigns(:user)).to be
    end
    it 'while new' do
      sign_out @user
      get :create, provider: 'github'
      expect(assigns(:user)).to be
    end
  end
end