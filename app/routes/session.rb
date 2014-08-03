module Todo
  class App < Sinatra::Base
    Warden::Manager.before_failure do |env, _|
      env['REQUEST_METHOD'] = 'POST'
    end
    
    Warden::Strategies.add(:password) do
      def valid?
        params['session'].present?
      end
      
      def authenticate!
        user = UserMapper.find email: params['session']['email']
        
        if user.valid_password? params['session']['password']
          success! user, 'Welcome user!'
        else
          throw :warden, message: 'Invalid email or password'
        end
      end
    end
    
    map_routes '/session' do
      post do
        warden.authenticate!
        flash[:success] = warden.message
        redirect new_items_path
      end
      
      delete do
        warden.logout
        redirect root_path
      end
      
      root :new do
        signed_out_only
      end
    end
    
    post '/unauthenticated' do
      flash[:error] = warden_options[:message] || 'Login to continue'
      redirect root_path
    end
  end
end
