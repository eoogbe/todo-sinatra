require 'spec_helper'
require './lib/models/errors'

describe Todo::Models::Errors do
  Given(:errors) { Todo::Models::Errors.new }
  
  describe '#add' do
    When { errors.add :foo, 'bar' }
    Then { errors[:foo] == Set['bar'] }
  end
  
  describe '#count' do
    Given { errors.add :foo, 'bar' }
    When(:result) { errors.count }
    Then { result == 1 }
  end
  
  describe '#base' do
    When { errors.base << 'foo' }
    Then { errors.count == 1 }
  end
end
