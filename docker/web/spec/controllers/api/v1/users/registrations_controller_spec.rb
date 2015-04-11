require 'spec_helper'

describe Api::V1::Users::RegistrationsController do
  user_mapping(:user)

  it '#create' do
    sign_out @user
    post :create, user: attributes_for(:user)
    expect(response).to redirect_to root_path
    expect(assigns(:user)).to be
  end
  it '#destroy' do
    delete :destroy
    expect(response).to redirect_to root_path
  end
end