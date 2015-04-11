# require 'spec_helper'

# describe 'Users', type: :feature, js: true do

#   before :each do
#     @user = FactoryGirl.build(:user)
#   end

#   it 'should register a user' do
#     visit '/users/sign_up'
#     within '.user-form' do
#       fill_in 'Full Name', with: @user.full_name
#       fill_in 'Email', with: @user.email
#       fill_in 'Password', with: 'password'
#       fill_in 'Confirm Password', with: 'password'
#       fill_in 'Username', with: @user.username
#       fill_in 'Location', with: @user.location
#       click_button('Register')
#     end
#     expect(page).to have_content('Explore')
#   end

#   it 'should login a user' do
#     visit '/users/sign_in'
#     within '.user-form' do
#       fill_in 'Email', with: @user.email
#       fill_in 'Password', with: @user.password
#       click_button('Log in')
#     end
#     expect(page).to have_content('Explore')
#   end

# end