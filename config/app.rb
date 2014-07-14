require 'sinatra/base'
require 'sinatra/reloader'
require 'rack/contrib'
require 'i18n'
require 'haml'
require 'sinatra/asset_pipeline'

require 'active_support/core_ext/object/blank'
require 'active_support/core_ext/hash/indifferent_access'
require 'active_support/core_ext/hash/slice'
require 'active_support/core_ext/string/inflections'

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
      use Rack::Locale
      I18n.load_path << File.join(__dir__, 'en.yml')
      I18n.enforce_available_locales = true
      enable :static
      set :root, File.expand_path('../', __dir__)
      set :views, File.join(settings.root, 'app', 'views')
      set :public_dir, File.join(settings.root, 'public')
      set :assets_prefix, %w(app/assets vendor/assets)
      set :assets_css_compressor, :sass
      set :assets_js_compressor, :uglifier
      register Sinatra::AssetPipeline
    end
  end
end

Dir[File.join Todo::App.settings.root, 'lib', '**', '*.rb'].each {|file| require file }
Dir[File.join Todo::App.settings.root, 'app', 'models', '**', '*.rb'].each {|file| require file }
Dir[File.join Todo::App.settings.root, 'app', 'mappers', '**', '*.rb'].each {|file| require file }
require File.join Todo::App.settings.root, 'app', 'helpers'
require File.join Todo::App.settings.root, 'app', 'controllers'
