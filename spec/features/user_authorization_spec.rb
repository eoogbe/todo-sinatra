require 'app_helper'

feature 'User authorization' do
  scenario 'when new item page' do
    NewItemPage.visit
    expect(page.current_path).to eq SignInPage.path
  end
  
  scenario 'when returning'
  
  scenario 'when sign in page' # should be signed out
end
