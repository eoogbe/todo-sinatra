require 'feature_helper'

feature 'Delete list item' do
  given!(:item) { Item.new text: 'The text' }
  given(:new_item_page) { @new_item_page }
  
  background do
    ItemMapper.insert item
    @new_item_page = NewItemPage.visit
  end
  
  scenario 'when deleting' do
    new_item_page.delete_item
    expect(new_item_page).to have_no_items
  end
end
