require 'spec_helper'

describe Api::V1::Users::SessionsController do
  user_mapping(:user)

  it '#create' do
    user = FactoryGirl.build(:user)
    post :create, email: user.email, password: user.password, format: :json
    expect(assigns(:auth_token)).to be
    expect(response).to have_http_status 200
  end
  it '#destroy' do
    delete :destroy, format: :json
    expect(response).to have_http_status 204
  end
end