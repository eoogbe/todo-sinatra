module Todo
  module View
    module Rendering
      def processed?
        !!@processed
      end
      
      attr_reader :view_name
      
      def render engine, data, *args, &block
        @view_name = data.to_s.tr('/', '.') unless data.to_s.include? 'layout'
        @processed = true
        super(engine, data, *args, &block)
      end
      
      def redirect *args, &block
        @processed = true
        super(*args, &block)
      end
    end
  end
end
