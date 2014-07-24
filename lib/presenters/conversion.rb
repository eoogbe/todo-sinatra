require 'active_support/core_ext/string/inflections'

module Todo
  module Presenters
    module Conversion
      def model_name
        model_class.demodulize.underscore
      end
      
      def model_class
        model.class.name
      end
    end
  end
end
