require 'active_support/core_ext/object/blank'
require 'active_support/core_ext/string/inflections'
require './lib/views/tagging'

module Todo
  module Forms
    class ErrorNotification
      include Todo::Views::Tagging
      
      def initialize object, template
        @object = object
        @template = template
      end
      
      def render
        return '' if errors.empty?
        
        tag :div, tag(:p, errors_heading) + tag(:ul, error_messages)
      end
      
      private
      attr_reader :object, :template
      
      def errors
        object.errors
      end
      
      def numbered_errors
        "#{errors.size} #{'errors'.pluralize(errors.size)}"
      end
      
      def errors_heading
        "#{numbered_errors} prohibited this item from being saved:"
      end
      
      def error_messages
        errors.map { |error| "<li>#{message_for(*error)}</li>" }.join
      end
      
      def message_for attr, type
        attr_msg(attr) + type_msg(type)
      end
      
      def attr_msg attr
        attr_msg = template.translate attr, default: attr.to_s.humanize,
          scope: [:models, object.model_name, :attrs]
        attr_msg.present? ? "#{attr_msg} " : ''
      end
      
      def type_msg type
        defaults = { default: type.to_s.humanize, scope: [:errors] }
        options = defaults.merge errors.options[type]
        template.translate type, options
      end
    end
  end
end
