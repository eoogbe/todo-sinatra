require File.expand_path '../../app/models/item', __dir__
require 'rspec/given'

describe Item do
  describe '#validate' do
    When(:valid) { item.validate }
    
    context 'when valid' do
      Given(:item) { Item.new text: 'The text' }
      Then { valid }
    end
    
    context 'when invalid' do
      Given(:item) { Item.new }
      Then { !valid }
      And { item.errors[:text] == :blank }
    end
  end
end
