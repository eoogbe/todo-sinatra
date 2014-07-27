require 'spec_helper'
require './lib/forms/input_field'

describe Todo::Forms::InputField do
  describe '#render' do
    Given(:obj) do
      double 'object', foo: 'bar', password: 'pass',
        email: 'obj@example.com', model_name: 'obj'
    end
    
    Given(:default_html) do
      { name: 'obj[foo]', value: 'bar', id: 'obj-foo', type: :text,
        class: 'form-control', 'aria-required' => 'true', required: true }
    end
    
    Given { allow(input_field).to receive(:tag) {|_, attrs| attrs }}
    
    When(:result) { input_field.render }
    
    context 'when using defaults' do
      Given(:input_field) { Todo::Forms::InputField.new obj, :foo }
      Then { result == default_html }
    end
    
    context 'when overriding defaults' do
      Given(:input_field) { Todo::Forms::InputField.new obj, :foo, options }
      Given(:expected) { default_html.merge options }
      
      context 'with html attrs' do
        Given(:options) {{ class: 'foo' }}  
        Then { result == expected }
      end
      
      context 'with name' do
        Given(:options) {{ name: 'foo' }}
        Then { result == expected }
      end
      
      context 'with id' do
        Given(:options) {{ id: 'foo' }}  
        Then { result == expected }
      end
      
      context 'with value' do
        Given(:options) {{ value: 'foo' }}  
        Then { result == expected }
      end
      
      context 'with type' do
        Given(:options) {{ type: :foo }}  
        Then { result == expected }
      end
    end
    
    context 'with html attrs' do
      Given(:input_field) { Todo::Forms::InputField.new obj, :foo, options }
      Given(:options) {{ placeholder: 'foo' }}
      
      Then { result == default_html.merge(options) }
    end
    
    context 'with value' do
      context 'when password' do
        Given(:input_field) { Todo::Forms::InputField.new obj, :password }
        
        Given(:expected) do
          default_html.merge name: 'obj[password]', value: '',
            id: 'obj-password', type: :password
        end
        
        Then { result == expected }
      end
      
      context 'when nonexistent' do
        Given(:input_field) { Todo::Forms::InputField.new obj, :foo }
        Given { allow(obj).to receive(:foo).and_return '' }
        
        Then { result == default_html.merge({ value: '' }) }
      end
    end
    
    context 'with type' do
      context 'when email' do
        Given(:input_field) { Todo::Forms::InputField.new obj, :email }
        
        Given(:expected) do
          default_html.merge name: 'obj[email]', value: 'obj@example.com',
            id: 'obj-email', type: :email
        end
        
        Then { result == expected }
      end
      
      context 'when password' do
        Given(:input_field) { Todo::Forms::InputField.new obj, :password }
        
        Given(:expected) do
          default_html.merge name: 'obj[password]', value: '',
            id: 'obj-password', type: :password
        end
        
        Then { result == expected }
      end
    end
    
    context 'when no object' do
      Given(:input_field) { Todo::Forms::InputField.new nil, :foo }
      
      Given(:expected) do
        default_html.merge name: :foo, id: :foo, value: ''
      end
      
      Then { result == expected }
    end
  end
end
