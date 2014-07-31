require 'active_support/core_ext/object/blank'
require './lib/views/tagging'

module Todo
  module Forms
    class InputField
      include Todo::Views::Tagging
      
      def initialize object, attr, options = {}
        @object = object
        @attr = attr
        @options = options
      end
      
      def render
        tag :input, html_attrs
      end
      
      def id
        options[:id] || "#{model}-#{attr}"
      end
      
      private
      attr_reader :object, :attr, :options
      
      def model
        object.respond_to?(:model_name) ? object.model_name : object
      end
      
      def default_html
        { class: 'form-control', 'aria-required' => 'true', required: true }
      end
      
      def calculated_html
        { type: type, name: name, value: value, id: id }
      end
      
      def html_attrs
        default_html.merge(calculated_html).merge options
      end
      
      def name
        options[:name] || "#{model}[#{attr}]"
      end
      
      def value
        return options[:value] if options[:value]
        return '' if type == :password || !object.respond_to?(attr)
        
        val = object.send attr
        val.present? ? val : ''
      end
      
      def type
        @type ||= options[:type] || default_type
      end
      
      def default_type
        case attr
        when /email/ then :email
        when /password/ then :password
        else :text
        end
      end
    end
  end
end
