require './lib/forms/error_notification'
require './lib/forms/input'
require './lib/views/tagging'

module Todo
  module Forms
    class FormBuilder
      include Todo::Views::Tagging
      
      def initialize object, template
        @object = object
        @template = template
      end
      
      def error_notification
        ErrorNotification.new(object, template).render
      end
      
      def input attr, options = {}
        Input.new(object, attr, options).render
      end
      
      def submit text
        tag :button, text, { class: 'btn btn-primary', type: :submit }
      end
      
      private
      attr_reader :object, :template
    end
  end
end
