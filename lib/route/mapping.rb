module Todo
  module Route
    module Mapping
      module Helpers
        def trigger path
          call! env.merge 'PATH_INFO' => path
        end
        
        def root_path
          '/'
        end
      end
      
      def map_routes namespace, &block
        mapping = Mapper.new namespace
        mapping.instance_exec(&block)
        mapping.routes.each do |route|
          namespace route[:namespace] do
            send route[:method], route[:path] do
              res = instance_exec(&route[:block]) if route[:block]
              
              if processed?
                res
              else
                haml route[:view].to_sym, layout: Todo::App.settings.layout
              end
            end
          end
          
          define_method "#{route[:name]}_path" do
            route[:namespace] + route[:path]
          end
        end
      end
      
      def self.registered app
        app.helpers Helpers
      end
    end
  end
end
