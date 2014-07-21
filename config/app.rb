require 'sinatra/base'
require 'sinatra/config_file'
require 'sinatra/namespace'
require 'rack/contrib'
require 'warden'
require 'bcrypt'
require 'sinatra/flash'
require 'i18n'
require 'haml'
require 'sass'
require 'sinatra/asset_pipeline'
require 'autoprefixer-rails'

require 'active_support/core_ext/object/blank'
require 'active_support/core_ext/hash/indifferent_access'
require 'active_support/core_ext/hash/slice'
require 'active_support/core_ext/string/inflections'

lib_files = File.join 'lib', '**', '*.rb'
Dir[lib_files].each {|file| require "./#{file}" }

module Todo
  class App < Sinatra::Base
    configure :development do
      set :database, 'todo-dev'
    end
    
    configure :test do
      set :database, 'todo-test'
    end
    
    configure do
      register Sinatra::ConfigFile
      config_file File.join __dir__, 'secrets.yml'
      
      register Sinatra::Namespace
      
      use Rack::Locale
      use Rack::Session::Cookie, secret: settings.session_key
      
      I18n.load_path << File.join(__dir__, 'en.yml')
      I18n.enforce_available_locales = true
      
      enable :static
      enable :method_override
      register Sinatra::Flash
      
      set :root, File.expand_path('../', __dir__)
      set :views, File.join(settings.root, 'app', 'views')
      set :public_dir, File.join(settings.root, 'public')
      set :layout, :'layouts/app'  # kludgy way of getting the layout to work
      set :haml, layout: settings.layout
      
      set :assets_prefix, %w(app/assets vendor/assets)
      set :assets_css_compressor, :sass
      set :assets_js_compressor, :uglifier
      register Sinatra::AssetPipeline
      AutoprefixerRails.install settings.sprockets
      
      helpers Todo::View::Rendering
      register Todo::Route::Mapping
      
      require './app/view_helper'
      helpers ViewHelper
    end
    
    def req_params
      params.with_indifferent_access
    end
  end
end

components = '{models,mappers,routes}'
app_files = File.join Todo::App.settings.root, 'app', components, '**', '*.rb'
Dir[app_files].each {|file| require file }
