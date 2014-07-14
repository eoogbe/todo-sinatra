require 'slim'

module Todo
  class App < Sinatra::Base
    get '/' do
      slim :items_new, locals: { items: Perpetuity[Item].all }
    end
    
    post '/items' do
      item = Item.new params[:item].slice 'text'
      Perpetuity[Item].insert item
      slim :items_new, locals: { items: Perpetuity[Item].all }
    end
  end
end
