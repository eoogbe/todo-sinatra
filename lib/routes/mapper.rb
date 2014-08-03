require 'active_support/core_ext/object/blank'
require 'active_support/core_ext/string/inflections'
require './lib/core/string_ext'

module Todo
  module Routes
    class Mapper
      REQUEST_METHODS = %i(get post put delete)
      
      def initialize namespace
        @scope = { namespace: namespace }
      end
      
      def routes
        @routes ||= []
      end
      
      REQUEST_METHODS.each do |method|
        define_method(method) do |*args, &block|
          map_methods(method, *args, &block)
        end
      end
      
      def member
        recover = scope.dup
        scope[:on] = :member
        yield
        self.scope = recover
      end
      
      def root name = nil, &block
        route = { namespace: '/', method: :get, block: block, path: '',
          name: 'root', on: :collection, fullpath: '/' }
        route[:view] = create_route_view route[:method], name, scope
        routes << route
      end
      
      private
      attr_accessor :scope
      
      def map_methods method, *args, &block
        options = args.last.is_a?(Hash) ? args.pop : {}
        options = scope.merge options
        
        name = args.shift
        path = (args.shift || name).to_s.trim '/'
        
        base_name = options[:namespace].trim('/').tr '/', '_'
        base_name = base_name.singularize if options[:on] == :member
        
        route = { method: method, block: block }
        
        route[:namespace] = options[:namespace]
        route[:on] = options[:on] || :collection
        
        route[:name] = base_name
        route[:name] = "#{name}_#{route[:name]}" if name
        
        route[:path] = ''
        route[:path] += '/:id' if options[:on] == :member
        route[:path] += "/#{path}" if path.present?
        
        route[:view] = create_route_view method, name, options
        route[:fullpath] = route[:namespace] + route[:path]
        
        routes << route
      end
      
      def create_route_view method, name, options
        view = options[:namespace].trim '/'
        view = view.singularize if options[:on] == :member
        view += name ? "/#{name}" : "/#{method}"
        view
      end
    end
  end
end
