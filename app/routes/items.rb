module Todo
  class App < Sinatra::Base
    map_routes '/items' do
      post do
        item = Item.new item_params
        
        if item.validate
          item_mapper.insert item
          redirect root_path
        else
          self.item = ItemPresenter.new item
          haml_with_layout :'items/new'
        end
      end
      
      root :new
      
      member do
        delete do
          item_mapper.delete req_params[:id]
          redirect root_path
        end
      end
    end
    
    def item
      @item ||= ItemPresenter.new
    end
    
    def items
      item_mapper.all
    end
    
    private
    attr_writer :item
    
    def item_params
      req_params[:item].slice :text
    end
    
    def item_mapper
      @item_mapper ||= ItemMapper.new
    end
  end
end
