require 'sinatra/base'

module Todo
  class App < Sinatra::Base
    get '/' do
      'Hello world!'
    end
  end
end
