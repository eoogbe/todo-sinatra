require 'active_support/core_ext/object/blank'
require File.expand_path '../core/string_ext', __dir__

module Todo
  module Route
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
        recover = scope
        scope[:on] = :member
        yield
        self.scope = recover
      end
      
      def nested namespace
        recover = scope
        namespace = "/#{namespace}" unless namespace.start_with? '/'
        scope[:namespace] += namespace
        yield
        self.scope = recover
      end
      
      private
      attr_accessor :scope
      
      def map_methods method, *args, &block
        options = args.last.is_a?(Hash) ? args.pop : {}
        options = scope.merge options
        
        name = args.shift
        path = (args.shift || name).to_s.trim '/'
        
        base_name = base_name_from options
        route = { method: method, block: block }
        
        route[:namespace] = options[:namespace]
        
        route[:name] = base_name
        route[:name] = "#{name}_#{route[:name]}" if name
        
        route[:path] = ''
        route[:path] += '/:id' if options[:on] == :member
        route[:path] += "/#{path}" if path.present?
        
        route[:view] = name ? "#{base_name}/#{name}" : "#{base_name}/#{method}"
        
        routes << route
      end
      
      def base_name_from options
        if options[:on] == :member
          segments = options[:namespace].trim('/').split '/'
          const_seg = segments.pop.humanize.singularize.tr ' ', '_'
          segments.join('_') + const_seg
        else
          options[:namespace].trim('/').tr '/', '_'
        end
      end
    end
  end
end
