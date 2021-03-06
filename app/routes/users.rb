module Todo
  class App < Sinatra::Base
    map_routes '/users' do
      post do
        signed_out_only
        user = User.new user_params
        
        if user.validate
          UserMapper.insert user
          redirect root_path
        else
          self.user = UserPresenter.new user
          haml_with_layout :'users/new'
        end
      end
      
      get :new do
        signed_out_only
      end
    end
    
    def user
      @user ||= UserPresenter.new
    end
    
    private
    attr_writer :user
    
    def user_params
      req_params[:user].slice :email, :password, :password_confirmation
    end
  end
end
