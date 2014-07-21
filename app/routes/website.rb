module Todo
  class App < Sinatra::Base
    get('/') { trigger new_items_path }
  end
end
