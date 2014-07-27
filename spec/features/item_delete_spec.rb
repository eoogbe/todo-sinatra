require 'app_helper'

feature 'Delete list item' do
  given!(:item) { create_item }
  given!(:user) { create_user }
  given(:new_item_page) { @new_item_page }
  
  background do
    SignInPage.visit.sign_in user.email, user.password
    @new_item_page = NewItemPage.visit
  end
  
  scenario 'when deleting' do
    new_item_page.delete_item
    expect(new_item_page).to be_current_page
    expect(new_item_page).to have_no_items
  end
end
