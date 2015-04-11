require "spec_helper"

describe UserMailer, :type => :mailer do
  let(:user){create(:user)}

  it '#welcome_email' do 
    @email = UserMailer.welcome_email(user)
    expect(@email.to).to eq [user.email]
  end
end
