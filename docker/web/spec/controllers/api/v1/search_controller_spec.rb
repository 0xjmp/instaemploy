require 'spec_helper'

describe Api::V1::SearchController do

  it '#show' do
    get :show, query: "Project", format: :json
    expect(assigns(:projects)).to be
    expect(assigns(:users)).to be
    expect(response).to have_http_status 200
  end

end