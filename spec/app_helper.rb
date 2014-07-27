ENV['RACK_ENV'] = 'test'
require './config/app'
require 'capybara/rspec'
require 'spec_helper'
Dir[File.join __dir__, 'support', '**', '*.rb'].each {|file| require file }

RSpec.configure do |config|
  Capybara.app = Todo::App
  
  config.include Warden::Test::Helpers
  config.include ObjectMother
  
  config.before :suite do
    Todo::Db::Connection.open do |connection|
      connection.drop_all
      Todo::Db::AddVersions.new(connection).exec
    end
  end

  config.after :each do
    Warden.test_reset!
    Todo::Db::Connection.open do |connection|
      connection.truncate_all
    end
  end
end
