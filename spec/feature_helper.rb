ENV['RACK_ENV'] = 'test'
require File.expand_path '../config/app', __dir__
require 'capybara/rspec'

RSpec.configure do |config|
  Capybara.app = Todo::App
  
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
