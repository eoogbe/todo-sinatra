require 'spec_helper'
require './lib/core/object_ext'

describe Object do
  describe '#mass_assign' do
    class ObjectStub
      attr_accessor :attr
    end
    
    Given(:obj) { ObjectStub.new }
    When { obj.mass_assign attr: 'value' }
    Then { obj.attr == 'value' }
  end
end
