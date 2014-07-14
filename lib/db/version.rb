require 'forwardable'

module Todo
  module Db
    class Version
      REGEX = %r[/(\d+)_(.+).rb$]
      extend Forwardable
      def_delegator :@connection, :execute
      
      def initialize connection
        @connection = connection
      end
    end
  end
end
