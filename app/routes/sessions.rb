module Todo
  class App < Sinatra::Base
    Warden::Manager.before_failure do |env, _|
      env['REQUEST_METHOD'] = 'POST'
    end
    
    Warden::Strategies.add(:password) do
      def valid?
        params['email'].present? && params['password'].present?
      end
      
      def authenticate!
        user = UserMapper.find email: params['email']
        
        if user.valid_password? params['password']
          success! user, 'Welcome user!'
        else
          throw :warden, message: 'Invalid email or password'
        end
      end
    end
    
    map_routes '/sessions' do
      post do
        warden.authenticate!
        flash[:success] = warden.message
        redirect root_path
      end
      
      get :new
    end
    
    post '/unauthenticated' do
      flash[:error] = warden_options[:message] || 'Login to continue'
      redirect new_sessions_path
    end
  end
end
