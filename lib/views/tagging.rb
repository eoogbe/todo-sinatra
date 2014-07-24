require 'haml'

module Todo
  module Views
    module Tagging
      include Haml::Helpers
      
      def tag name, content = nil, attrs = nil, &block
        init_haml_helpers if @haml_buffer.nil?
        
        if block_given?
          attrs = content
          content = capture_haml(&block)
        end
        
        attrs ||= {}
        capture_haml { haml_tag name, content, attrs }
      end
    end
  end
end
