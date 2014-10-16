module Todo
  class App < Sinatra::Base
    map_routes '/items' do
      post do
        signed_in_only
        item = Item.new item_params
        item.user = current_user
        
        if item.validate
          item_mapper.insert item
          redirect new_items_path
        else
          self.item = ItemPresenter.new item
          haml_with_layout :'items/new'
        end
      end
      
      get :new do
        signed_in_only
      end
      
      member do
        delete do
          signed_in_only
          item_mapper.delete req_params[:id]
          redirect new_items_path
        end
      end
    end
    
    def item
      @item ||= ItemPresenter.new
    end
    
    def items
      @items ||= item_mapper.where_user(current_user)
    end
    
    private
    attr_writer :item
    
    def item_params
      req_params[:item].slice :text
    end
    
    def item_mapper
      @item_mapper ||= ItemMapper.new
    end
    
    def current_user
      warden.user
    end
  end
end
