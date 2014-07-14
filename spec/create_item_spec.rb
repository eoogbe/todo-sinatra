ENV['RACK_ENV'] = 'test'
require 'capybara/rspec'
require File.expand_path '../config/app', __dir__

RSpec.configure do |config|
  config.before :suite do
    Todo::Db::Connection.open do |connection|
      connection.drop_all
      Todo::Db::AddVersions.new(connection).exec
    end
  end

  config.after :each do
    Todo::Db::Connection.open do |connection|
      connection.truncate_all
    end
  end
end

feature 'Create list item' do
  Capybara.app = Todo::App
  
  scenario 'when valid' do
    visit '/'
    fill_in 'Item', with: 'Apples'
    click_on 'Add Item'
    expect(page).to have_selector 'ol > li', text: 'Apples'
  end
  
  scenario 'when invalid' do
    visit '/'
    click_on 'Add Item'
    expect(page).not_to have_selector 'ol'
    expect(page).to have_selector 'form .errors li', text: 'Text must not be blank'
  end
end
