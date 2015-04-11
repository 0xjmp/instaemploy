require 'spec_helper'

describe Alert do
  before :each do
    @alert = FactoryGirl.create(:alert)
  end

  it 'should have an email' do
    expect(@alert.email).to eq 'test@instaemploy.com'
  end

  it 'should have skills' do
    expect(@alert.skills.length > 0).to be true
  end

  it 'should find new skills' do
    tag = @alert.skills.first.name

    p = FactoryGirl.build(:project)
    p.skill_list = tag
    p.save!

    Alert.find_new_skills

    expect(@alert).to_not eq nil
  end

end