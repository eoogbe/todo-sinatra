require_relative 'page_object'

class NewItemPage < PageObject
  def self.path
    '/items/new'
  end
  
  def add_item text
    fill_in 'Item', with: text
    click_on 'Add Item'
  end
  
  def delete_item
    find('table').click_on 'delete'
  end
  
  def sign_out
    click_on 'Sign out'
  end
  
  def current_page?
    self.class.path == page.current_path
  end
  
  def has_item? text
    has_selector? 'td', text: text
  end
  
  def has_no_item? text
    has_no_selector? 'td', text: text
  end
  
  def has_no_items?
    has_no_selector? 'table'
  end
  
  def has_error?
    has_content? 'Item must not be blank'
  end
end
