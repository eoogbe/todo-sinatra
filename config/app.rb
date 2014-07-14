require 'sinatra/base'
require 'sinatra/reloader'
require 'perpetuity/mongodb'
require 'active_support/core_ext/hash/slice'

module Todo
  class App < Sinatra::Base
    configure :development do
      set :database, 'todo-dev'
      register Sinatra::Reloader
    end
    
    configure :test do
      set :database, 'todo-test'
    end
    
    configure do
      set :root, File.expand_path('../..', __FILE__)
      set :views, settings.root + '/app/views'
      set :view_types, %w(html)
      Perpetuity.data_source :mongodb, settings.database
    end
    
    helpers do
      def find_template(views, name, engine, &block)
        settings.view_types.each do |type|
          super views, "#{name}.#{type}", engine, &block
        end
      end
    end
  end
end

Dir[Todo::App.settings.root + '/lib/**/*.rb'].each {|file| require file }
Dir[Todo::App.settings.root + '/app/models/**/*.rb'].each {|file| require file }
require Todo::App.settings.root + '/app/mappers'
require Todo::App.settings.root + '/app/controllers'
