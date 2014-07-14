require 'capybara/rspec'
require File.expand_path '../../config/app', __FILE__

RSpec.configure do |config|
  config.before :suite do
    Todo::Db::Connection.open do |connection|
      connection.truncate_all
    end
  end

  config.after :each do
    Todo::Db::Connection.open do |connection|
      connection.truncate_all
    end
  end
end

feature 'Create list' do
  Capybara.app = Todo::App
  
  scenario 'when valid' do
    visit '/'
    fill_in 'Item', with: 'Apples'
    click_on 'Add Item'
    expect(page).to have_selector 'ol > li', text: 'Apples'
  end
end
