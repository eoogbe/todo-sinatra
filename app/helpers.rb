module Todo
  class App < Sinatra::Base
    helpers do
      def t *args
        I18n.t(*args)
      end
      
      def req_params
        params.with_indifferent_access
      end
      
      def pluralize count, str
        "#{count} #{str.pluralize count}"
      end
    end
  end
end
