module Todo
  module Models
    module Validations
      def validates_presence_of *attrs
        attrs.each {|attr| errors.add attr, :blank if send(attr).blank? }
      end
      
      def validates_uniqueness_of attr
        errors.add attr, :duplicate if repository.exists? attr => send(attr)
      end
      
      def validates_format_of attr, format
        errors.add attr, :format unless send(attr) =~ format
      end
      
      def validates_confirmation_of attr
        if send(attr) != send("#{attr}_confirmation")
          errors.add attr, :confirmation
        end
      end
      
      def validates_length_of attr, options
        value = send(attr)
        return unless value.present?
        
        if options[:min] && value.length < options[:min]
          errors.add attr, :too_short, count: options[:min]
        end
        
        if options[:max] && value.length > options[:max]
          errors.add attr, :too_long, count: options[:max]
        end
      end
      
      def errors
        @errors ||= Todo::Models::Errors.new
      end
    end
  end
end
