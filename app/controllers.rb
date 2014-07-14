module Todo
  class App < Sinatra::Base
    get '/' do
      haml :items_new, locals: { item: Item.new, items: ItemMapper.new.all }
    end
    
    post '/items' do
      item = Item.new req_params[:item].slice :text
      item_mapper = ItemMapper.new
      
      if item.validate
        item_mapper.insert item
        redirect '/'
      else
        haml :items_new, locals: { item: item, items: item_mapper.all }
      end
    end
  end
end
