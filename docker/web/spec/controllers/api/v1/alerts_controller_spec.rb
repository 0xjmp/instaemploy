require 'spec_helper'

describe Api::V1::AlertsController do
  let(:alert){create(:alert)}

  user_mapping(:user)

  it 'create' do
    post :create, alert: attributes_for(:alert), format: :json
    expect(response).to have_http_status :accepted
  end

  it 'destroy' do
    delete :destroy, id: alert.id, format: :json
    expect(response).to have_http_status :no_content
    expect(assigns(:alert)).to_not be
  end
end