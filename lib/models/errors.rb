require 'set'
require 'forwardable'
require 'active_support/core_ext/object/blank'

module Todo
  module Models
    class Errors
      class Base
        def to_s
          ''
        end
      end
      
      extend Forwardable
      include Enumerable
      def_delegators :errors, :[], :blank?, :empty?, :present?
      
      def add attr, type
        errors[attr] ||= Set.new
        errors[attr] << type
      end
      
      def count
        errors.reduce(0) {|sum, (_, types)| sum + types.length }
      end
      alias_method :size, :count
      
      def each
        errors.each do |attr, types|
          types.each {|type| yield [attr, type] }
        end
      end
      
      def base
        errors[Base.new] ||= Set.new
      end
      
      private
      def errors
        @errors ||= {}
      end
    end
  end
end
