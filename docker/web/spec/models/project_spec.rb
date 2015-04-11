require 'spec_helper'

describe Project do
  before :each do
    @project = create(:project)
    @user = create(:user)
  end

  it 'should follow' do
    @project.follow!(@user)
    @project.reload
    expect(@project.following?(@user)).to be true
  end
  it 'should unfollow' do
    @project.followers << @user
    @project.unfollow!(@user)
    @project.reload
    expect(@project.following?(@user)).to be false
  end

  it 'should find by skill' do
    name = "test skill"
    @project.skill_list = name
    @project.save!

    projects = Project.by_skill(name)
    expect(projects).to eq([@project])
  end

  it 'should have a current state' do
    state = @project.current_state(@user)
    expect(state).to eq 'incomplete'
  end

  it 'should have a user' do
    expect(@project.user).to be
  end
end