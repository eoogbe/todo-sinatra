module Todo
  class App < Sinatra::Base
    use Warden::Manager do |config|
      config.default_strategies :password
      config.failure_app = Todo::App
      config.serialize_into_session{|user| user.id }
      config.serialize_from_session{|id| UserMapper.find id }
    end
    
    Warden::Manager.before_failure do |env, _|
      env['REQUEST_METHOD'] = 'POST'
    end
    
    Warden::Strategies.add(:password) do
      def valid?
        params['user']['email'].present? && params['user']['password'].present?
      end
      
      def authenticate!
        user = UserMapper.find email: params['user']['email']
        if user.valid_password? params['user']['password']
          success! user, 'Welcome user!'
        else
          fail!
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
      flash.now[:error] = 'Invalid email or password'
      haml_with_layout :'sessions/new'
    end
    
    def user
      @user ||= UserPresenter.new
    end
    
    private
    attr_writer :user
    
    def warden
      env['warden']
    end
  end
end
