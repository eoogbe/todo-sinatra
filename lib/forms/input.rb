require 'active_support/core_ext/string/inflections'
require './lib/views/tagging'

module Todo
  module Forms
    class Input
      include Todo::Views::Tagging
      
      def initialize object, attr, options = {}, input_field_creator = nil
        @object = object
        @attr = attr
        @options = options
        @input_field_creator =
          input_field_creator || InputField.public_method(:new)
      end
      
      def render
        tag :div, label + input_field.render, wrapper_html
      end
      
      private
      attr_reader :object, :attr, :options
      
      def wrapper_html
        { class: 'form-group' }.merge options[:wrapper_html] || {}
      end
      
      def label
        tag :label, label_text, label_html
      end
      
      def label_text
        options[:label_text] || attr.to_s.humanize
      end
      
      def label_html
        { for: input_field.id }.merge options[:label_html] || {}
      end
      
      def input_field
        @input_field ||= @input_field_creator.call object, attr,
          options[:input_html] || {}
      end
    end
  end
end
