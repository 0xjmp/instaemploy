require 'spec_helper'

describe User do
  before(:each) do
    @project = create(:project)
    @user = create(:user)
  end

  it 'should search' do
    results = User.search("Test")
    expect(results).to eq []
  end

  it 'should have recent projects' do
    expect(@user.recent_projects).to be
  end

  it 'should have popular projects' do
    expect(@user.popular_projects).to be
  end

  it 'should have interesting projects' do
    expect(@user.interesting_projects).to be
  end

  it 'should have an auth token' do
    expect(@user.auth_token).to be
  end
end