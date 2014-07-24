require './lib/routes/mapper'

module Todo
  module Routes
    module Mapping
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
                haml_with_layout route[:view].to_sym
              end
            end
          end
          
          define_method "#{route[:name]}_path" do
            route[:namespace] + route[:path]
          end
        end
      end
    end
  end
end
