require './app/view_helper'

module Todo
  class App < Sinatra::Base
    configure do
      helpers Todo::Views::Rendering
      register Todo::Routes::Mapping
      
      helpers Todo::Views::Tagging
      helpers ViewHelper
    end
    
    private
    def req_params
      params.with_indifferent_access
    end
    
    def warden
      env['warden']
    end
    
    def warden_options
      env['warden.options']
    end
    
    def signed_in_only
      warden.authenticate!
    end
    
    def signed_out_only
      redirect root_path if signed_in?
    end
    
    def signed_in?
      warden.authenticated?
    end
  end
end

route_files = File.join Todo::App.settings.root, 'app', 'routes', '**', '*.rb'
Dir[route_files].each {|file| require file }
