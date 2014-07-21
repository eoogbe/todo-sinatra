require 'feature_helper'

feature 'Delete list item' do
  given!(:item) { Item.new text: 'The text' }
  
  background do
    ItemMapper.insert item
    visit '/'
  end
  
  scenario 'when deleting' do
    find('table').click_on 'delete'
    expect(page).not_to have_selector 'td', text: item.text
  end
end
