require 'spec_helper'

describe Api::V1::SkillsController do
  let(:project){create(:project)}

  user_mapping(:user)

  it '#show' do
    get :show, name: project.skills.first.name, format: :json
    expect(assigns(:projects)).to eq([project])
  end

end