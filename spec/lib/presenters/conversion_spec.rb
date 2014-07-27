require 'spec_helper'
require './lib/presenters/conversion'

class TestFoo
  include Todo::Presenters::Conversion
  
  def model
    self
  end
end

module TestModule
  class TestBar
    include Todo::Presenters::Conversion
    
    def model
      self
    end
  end
end

describe Todo::Presenters::Conversion do
  describe '#model_name' do
    context 'without module' do
      Given(:obj) { TestFoo.new }
      When(:result) { obj.model_name }
      Then { result == 'test_foo' }
    end
    
    context 'with module' do
      Given(:obj) { TestModule::TestBar.new }
      When(:result) { obj.model_name }
      Then { result == 'test_bar' }
    end
  end
end
