require 'feature_helper'

feature 'Sign in user' do
  given!(:user) { User.new email: 'user1@example.com', password: 'foobar' }
  
  background do
    UserMapper.insert user
    visit '/sessions/new'
  end
  
  scenario 'when valid' do
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Sign In'
    expect(page).to have_content 'Welcome user!'
  end
  
  scenario 'when invalid'
end
